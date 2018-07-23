module Lesson04
  ( ifEvenInc, ifEvenDouble, ifEvenSquare
  , author, names
  , compareLastNames, addressLetter
  , sfOffice, nyOffice, renoOffice, getLocationFunction
  ) where

ifEvenInc :: Int -> Int
ifEvenInc n = ifEven inc n

ifEvenDouble :: Int -> Int
ifEvenDouble n = ifEven double n

ifEvenSquare :: Int -> Int
ifEvenSquare n = ifEven square n

ifEven  :: (Int -> Int) -> Int -> Int
ifEven myFunction x =
  if even x
  then myFunction x
  else x

inc :: Int -> Int
inc n = n + 1

double :: Int -> Int
double n = n * 2

square :: Int -> Int
square n = n^2

author :: (String, String)
author = ("Will", "Kurt")

names :: [(String, String)]
names =
  [ ("Ian", "Curtis")
  , ("Bernard", "Sumner")
  , ("Peter", "Hook")
  , ("Stephen", "Morris")
  ]

compareLastNames :: (String, String) -> (String, String) -> Ordering
compareLastNames name1 name2 =
  if lastName1 > lastName2
  then GT
  else
    if lastName1 < lastName2
    then LT
    else EQ
  where
    lastName1 = snd name1
    lastName2 = snd name2

-- addressLetter :: (String, String) -> String -> String
-- addressLetter name location = nameText ++ " - " ++ location
--   where
--     nameText = fst name ++ " " ++ snd name

sfOffice :: (String, String) -> String
sfOffice name =
  if lastName < "L"
  then nameText ++ " - PO Box 1234 - San Francisco, CA, 94111"
  else nameText ++ " - PO Box 1010 - San Francisco, CA, 94109"
  where
    lastName = snd name
    nameText = fst name ++ " " ++ lastName

nyOffice :: (String, String) -> String
nyOffice name = nameText ++ " - PO Box 789 - New York, NY, 10013"
  where
    nameText = fst name ++ " " ++ snd name

renoOffice :: (String, String) -> String
renoOffice name = nameText ++ " - PO Box 456 - Reno, NV 89523"
  where
    nameText = snd name

getLocationFunction :: String -> ((String, String) -> String)
getLocationFunction location =
  case location of
    "ny" -> nyOffice
    "sf" -> sfOffice
    "reno" -> renoOffice
    _ -> (\name -> fst name ++ " " ++ snd name)

addressLetter :: (String, String) -> String -> String
addressLetter name location = locationFunction name
  where
    locationFunction = getLocationFunction location