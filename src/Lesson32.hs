module Lesson32 where

import Control.Monad (guard)

powerOfTwo :: Int -> [Int]
powerOfTwo n = do
  value <- [1 .. n]
  return (2^value)

powerOfTwoMap :: Int -> [Int]
powerOfTwoMap n = map (\x -> 2^x) [1..n]

powerOfTwoAndThree :: Int -> [(Int, Int)]
powerOfTwoAndThree n = do
  value <- [1..n]
  let powersOfTwo = 2^value
  let powersOfThree = 3^value
  return (powersOfTwo, powersOfThree)

allEvenOdds :: Int -> [(Int, Int)]
allEvenOdds n = do
  evanValue <- [2,4..n]
  oddValue <- [1,3..n]
  return (evanValue, oddValue)

evensGuard :: Int -> [Int]
evensGuard n = do
  value <- [1..n]
  guard (even value)
  return value

evenSquares :: [Int]
evenSquares = do
  n <- [0..9]
  let nSquared = n^2
  guard (even nSquared)
  return nSquared

powersOfTwoAndThree :: Int -> [(Int, Int)]
powersOfTwoAndThree n =
  [ (powersOfTwo, powersOfThree) | value <- [1..n]
  , let powersOfTwo = 2^value
  , let powersOfThree = 3^value
  ]

allEvenOdds' :: Int -> [(Int, Int)]
allEvenOdds' n =
  [ (evenValue, oddValue) | evenValue <- [2,4..n]
  , oddValue <- [1,3..n]
  ]

evensGuard' :: Int -> [Int]
evensGuard' n =
  [ value | value <- [1..n]
  , even value
  ]