module Lesson03
  ( sumSquareOrSquareSum
  ) where

sumSquareOrSquareSum :: Int -> Int -> Int
sumSquareOrSquareSum x y = body (x^2 + y^2) ((x+y)^2)

body :: Int -> Int -> Int
body sumSquare squareSum =
  if sumSquare > squareSum
  then sumSquare
  else squareSum