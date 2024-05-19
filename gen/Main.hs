module Main where

import Control.Monad.Except
import Control.Monad.Trans.Except
import System.Environment
import System.Exit
import System.IO

import TypeCheck
import Interpreter

import AbsGrammar
import ErrM
import ParGrammar

runFile :: String -> IO ()
runFile fName = readFile fName >>= run 

run :: String -> IO ()
run code =
  case pProgram $ myLexer code of
    Bad err -> hPutStrLn stderr err
    Ok prog -> do
      tcResult <- runExceptT $ typeCheck prog
      case tcResult of
        Bad err' -> hPrint stderr (show err')
        Ok _  -> do
          progResult <- runExceptT $ interpret prog
          case progResult of 
              Bad err'' -> hPutStrLn stderr err''
              Ok _ -> return ()

main :: IO ()
main = do
  args <- getArgs
  case args of
    []  -> getContents >>= run 
    fs  -> mapM_ runFile fs