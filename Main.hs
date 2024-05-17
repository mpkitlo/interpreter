module Main where

import Control.Monad.Except
import Control.Monad.Trans.Except
import System.Environment
import System.Exit
import System.IO

import TypeCheck
-- import Interpreter
-- import Types

import AbsGrammar
import ErrM
import ParGrammar

runFile :: String -> IO ()
runFile fName = readFile fName >>= run 

run :: String -> IO ()
run code =
  case pProgram $ myLexer code of
    (Bad err) -> hPutStrLn stderr err
    (Ok prog) -> do
      -- typeCheck prog
      tcResult <- runExceptT $ typeCheck prog
      case tcResult of
        Left err2 -> hPrint stderr (show err2)
        Right _ -> print "ok"

        -- case tcResult of
        --   Left r  -> print r
        --   Right r -> print r

main :: IO ()
main = do
  args <- getArgs
  case args of
    []  -> getContents >>= run 
    fs  -> mapM_ runFile fs