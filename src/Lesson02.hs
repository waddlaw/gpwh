module Lesson02
  ( simple
  , calcChange
  , calcChange2
  ) where

simple :: a -> a
simple x = x

calcChange :: Int -> Int -> Int
calcChange owed given =
  if given - owed > 0
  then given - owed
  else 0

calcChange2 :: Int -> Int -> Int
calcChange2 owed given =
  if change > 0
  then given - owed
  else 0
  where
    change = given - owed