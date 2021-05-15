module Main where

import Enigma

import System.IO

main :: IO ()
main = do
  putStr "Enter string to encode: "
  hFlush stdout
  input <- getLine
  putStrLn $ runEnigma defaultMachine input
  main
