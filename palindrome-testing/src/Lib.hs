module Lib
  ( isPalindrome
  , preprocess
  , isPalindromeT
  , preprocessT
  ) where

import qualified Data.Text as T
import Data.Char (isPunctuation)

preprocess :: String -> String
preprocess text = filter (not . isPunctuation) text

isPalindrome :: String -> Bool
isPalindrome text = cleanText == reverse cleanText
  where cleanText = preprocess text

preprocessT :: T.Text -> T.Text
preprocessT text = T.filter (not . isPunctuation) text

isPalindromeT :: T.Text -> Bool
isPalindromeT text = cleanText == T.reverse cleanText
  where cleanText = preprocessT text