{-# LANGUAGE OverloadedStrings #-}
module Main where

import Data.ByteString (ByteString)
import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as BC

import System.Environment
import System.Random
import Control.Monad

import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as TIO

import qualified Data.Text.Encoding as E

sampleBytes :: ByteString
sampleBytes = "Hello!"

sampleString :: String
sampleString = BC.unpack sampleBytes

intToChar :: Int -> Char
intToChar int = toEnum safeInt
  where safeInt = int `mod` 255

intToBC :: Int -> ByteString
intToBC int = BC.pack [intToChar int]

replaceByte :: Int -> Int -> ByteString -> ByteString
replaceByte loc charVal bytes = mconcat [ before, newChar, after ]
  where
    (before, rest) = BC.splitAt loc bytes
    after = BC.drop 1 rest
    newChar = intToBC charVal

randomReplaceByte :: ByteString -> IO ByteString
randomReplaceByte bytes = do
  let bytesLength = BC.length bytes
  location <- randomRIO (1, bytesLength)
  charVal <- randomRIO (0,255)
  return (replaceByte location charVal bytes)

sortSection :: Int -> Int -> ByteString -> ByteString
sortSection start size bytes = mconcat [ before, changed, after ]
  where
    (before, rest) = BC.splitAt start bytes
    (target, after) = BC.splitAt size rest
    changed = BC.reverse (BC.sort target)

randomSortSection :: ByteString -> IO ByteString
randomSortSection bytes = do
  let sectionSize = 25
  let bytesLength = BC.length bytes
  start <- randomRIO (0, bytesLength -sectionSize)
  return (sortSection start sectionSize bytes)

jaBC :: ByteString
jaBC = "あ"

jaText :: Text
jaText = "あ"

jaB :: ByteString
jaB = (BC.pack . T.unpack) jaText

jaSafe :: ByteString
jaSafe = E.encodeUtf8 jaText

main :: IO ()
main = do
  args <- getArgs
  let fileName = head args
  imageFile <- BC.readFile fileName

  glitched <- foldM (\bytes func -> func bytes) imageFile [ randomReplaceByte
                                                          , randomSortSection
                                                          , randomReplaceByte
                                                          , randomSortSection
                                                          , randomReplaceByte
                                                          ]

  let glitchedFileName = mconcat [ "glitched_", fileName ]
  BC.writeFile glitchedFileName glitched
  print "all done"