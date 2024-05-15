module Main where

import Control.Monad.Except
import Control.Monad.Trans.Except
import System.Environment
import System.Exit
import System.IO

-- import TypeCheck
-- import Interpreter
-- import Types

import AbsGrammar
import ErrM
import ParGrammar

main :: IO ()
main = do
  args <- getArgs
  case args of
    []  -> getContents >>= run 
    fs  -> mapM_ runFile fs

runFile :: String -> IO ()
runFile fName = readFile fName >>= run 

run :: String -> IO ()
run code =
  print (pProgram (myLexer code))
