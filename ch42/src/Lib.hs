module Lib where

import Data.Array.Unboxed

import Data.Array.ST
import Control.Monad
import Control.Monad.ST

someFunc :: IO ()
someFunc = putStrLn "someFunc"

aLargeList :: [Int]
aLargeList = [1 .. 10000000]

aLargeArray :: UArray Int Int
aLargeArray = array (0, 9999999) []

aLargeListDoubled :: [Int]
aLargeListDoubled = map (*2) aLargeList

zeroIndexArray :: UArray Int Bool
zeroIndexArray = array (0,9) [(3,True)]

oneIndexArray :: UArray Int Bool
oneIndexArray = array (1,10) $ zip [1..10] $ cycle [True]

beansInBuckets :: UArray Int Int
beansInBuckets = array (0,3) []

updatedBiB :: UArray Int Int
updatedBiB = beansInBuckets // [(1,5), (3,6)]

listToSTUArray :: [Int] -> ST s (STUArray s Int Int)
listToSTUArray vals = do
  let end = length vals - 1
  myArray <- newArray (0, end) 0
  forM_ [0..end] $ \i -> do
    let val = vals !! i
    writeArray myArray i val
  return myArray

listToUArray :: [Int] -> UArray Int Int
listToUArray vals = runSTUArray $ listToSTUArray vals

myData :: UArray Int Int
myData = listArray (0,5) [7,6,4,8,10,2]

bubbleSort :: UArray Int Int -> UArray Int Int
bubbleSort myArray = runSTUArray $ do
  stArray <- thaw myArray
  let end = (snd . bounds) myArray
  forM_ [1..end] $ \i -> do
    forM_ [0..(end-i)] $ \j -> do
      val <- readArray stArray j
      nextVal <- readArray stArray (j+1)
      let outOfOrder = val > nextVal
      when outOfOrder $ do
        writeArray stArray j nextVal
        writeArray stArray (j+1) val
  return stArray