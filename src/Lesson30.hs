module Lesson30 where

import Prelude hiding (id)

import           Data.Map (Map)
import qualified Data.Map as Map

type UserName = String
type GamerId = Int
type PlayerCredits = Int

userNameDB :: Map GamerId UserName
userNameDB = Map.fromList
  [ (1, "nYarlathoTep")
  , (2, "KINGinYELLOW")
  , (3, "dagon1997")
  , (4, "rcarter1919")
  , (5, "xCTHULHUx")
  , (6, "yogSOThoth")
  ]

creditsDB :: Map UserName PlayerCredits
creditsDB = Map.fromList
  [ ("nYarlathoTep", 2000)
  , ("KINGinYELLOW", 15000)
  , ("dagon1997", 300)
  , ("rcarter1919", 12)
  , ("xCTHULHUx", 50000)
  , ("yogSOThoth", 150000)
  ]

creditsFromId :: GamerId -> Maybe PlayerCredits
creditsFromId id = lookupUserName id >>= lookupCredits

lookupUserName :: GamerId -> Maybe UserName
lookupUserName id = Map.lookup id userNameDB

lookupCredits :: UserName -> Maybe PlayerCredits
lookupCredits username = Map.lookup username creditsDB

altLookupCredits :: Maybe UserName -> Maybe PlayerCredits
altLookupCredits Nothing = Nothing
altLookupCredits (Just username) = lookupCredits username

type WillCoId = Int

gamerIdDB :: Map WillCoId GamerId
gamerIdDB = Map.fromList
  [ (1001, 1)
  , (1002, 2)
  , (1003, 3)
  , (1004, 4)
  , (1005, 5)
  , (1006, 6)
  ]

lookupGamerId :: WillCoId -> Maybe GamerId
lookupGamerId id = Map.lookup id gamerIdDB

creditsFromWCId :: WillCoId -> Maybe PlayerCredits
creditsFromWCId id = lookupGamerId id >>= lookupUserName >>= lookupCredits

echo :: IO ()
echo = getLine >>= putStrLn

main :: IO ()
main = echo

echoVerbose :: IO ()
echoVerbose = putStrLn "Enter a String an we'll echo it!" >> getLine >>= putStrLn

askForName :: IO ()
askForName = putStrLn "What is your name?"

nameStatement :: String -> String
nameStatement name = "Hello, " ++ name ++ "!"

helloName :: IO ()
helloName = askForName >>
  getLine >>=
  (\name -> return (nameStatement name)) >>=
  putStrLn