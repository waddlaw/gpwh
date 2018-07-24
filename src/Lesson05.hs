module Lesson05 where

getRequestURL :: String -> String -> String -> String -> String
getRequestURL host apiKey resource id' =
  host ++ "/" ++ resource ++ "/" ++ id' ++ "?token=" ++ apiKey

genHostRequestBuilder :: String -> (String -> String -> String -> String)
genHostRequestBuilder = getRequestURL

exampleUrlBuilder :: String -> String -> String -> String
exampleUrlBuilder = genHostRequestBuilder "http://example.com"