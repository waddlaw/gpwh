{-# LANGUAGE OverloadedStrings #-}
module Lesson262 where

import Data.ByteString (ByteString)
import qualified Data.ByteString as B
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import qualified Data.Text.Encoding as E
import Data.Maybe

import Lesson26

type MarcRecordRaw = ByteString
type MarcLeaderRaw = ByteString

getLeader :: MarcRecordRaw -> MarcLeaderRaw
getLeader record = B.take leaderLength record

leaderLength :: Int
leaderLength = 24

rawToInt :: ByteString -> Int
rawToInt = (read . T.unpack . E.decodeUtf8)

getRecordLength :: MarcLeaderRaw -> Int
getRecordLength leader = rawToInt (B.take 5 leader)

nextAndRest :: ByteString -> (MarcRecordRaw, ByteString)
nextAndRest marcStream = B.splitAt recordLength marcStream
  where
    recordLength = getRecordLength marcStream

allRecords :: ByteString -> [MarcRecordRaw]
allRecords marcStream
  | marcStream == B.empty = []
  | otherwise = next:allRecords rest
  where
    (next, rest) = nextAndRest marcStream

type MarcDirectoryRaw = ByteString

getBaseAddress :: MarcLeaderRaw -> Int
getBaseAddress leader = rawToInt (B.take 5 remainder)
  where
    remainder = B.drop 12 leader

getDirectoryLength :: MarcLeaderRaw -> Int
getDirectoryLength leader = getBaseAddress leader - (leaderLength + 1)

getDirectory :: MarcRecordRaw -> MarcDirectoryRaw
getDirectory record = B.take directoryLength afterLeader
  where
    directoryLength = getDirectoryLength record
    afterLeader = B.drop leaderLength record

type MarcDirectoryEntryRaw = ByteString

dirEntryLength :: Int
dirEntryLength = 12

splitDirectory directory
  | directory == B.empty = []
  | otherwise = nextEntry : splitDirectory restEntries
  where
    (nextEntry, restEntries) = B.splitAt dirEntryLength directory

data FieldMetadata = FieldMetadata
  { tag :: Text
  , fieldLength :: Int
  , fieldStart :: Int
  } deriving Show

makeFieldMetadata :: MarcDirectoryEntryRaw -> FieldMetadata
makeFieldMetadata entry = FieldMetadata textTag theLength theStart
  where
    (theTag, rest) = B.splitAt 3 entry
    textTag = E.decodeUtf8 theTag
    (rawLength, rawStart) = B.splitAt 4 rest
    theLength = rawToInt rawLength
    theStart = rawToInt rawStart

getFieldMetadata :: [MarcDirectoryEntryRaw] -> [FieldMetadata]
getFieldMetadata rawEntries = map makeFieldMetadata rawEntries

type FieldText = Text

getTextField :: MarcRecordRaw -> FieldMetadata -> FieldText
getTextField record fieldMetadata = E.decodeUtf8 byteStringValue
  where
    recordLength = getRecordLength record
    baseAddress = getBaseAddress record
    baseRecord = B.drop baseAddress record
    baseAtEntry = B.drop (fieldStart fieldMetadata) baseRecord
    byteStringValue = B.take (fieldLength fieldMetadata) baseAtEntry

fieldDelimiter :: Char
fieldDelimiter = toEnum 31

titleTag :: Text
titleTag = "245"

titleSubfield :: Char
titleSubfield = 'a'

authorTag :: Text
authorTag = "100"

authorSubfield :: Char
authorSubfield = 'a'

lookupFieldMetadata :: Text -> MarcRecordRaw -> Maybe FieldMetadata
lookupFieldMetadata aTag record
  | length results < 1 = Nothing
  | otherwise = Just (head results)
  where
    metadata = (getFieldMetadata . splitDirectory . getDirectory) record
    results = filter ((== aTag) . tag) metadata

lookupSubfield :: Maybe FieldMetadata -> Char -> MarcRecordRaw -> Maybe Text
lookupSubfield Nothing _ _ = Nothing
lookupSubfield (Just fieldMetadata) subfield record
  | results == [] = Nothing
  | otherwise = Just ((T.drop 1 . head) results)
  where
    rawField = getTextField record fieldMetadata
    subfields = T.split (== fieldDelimiter) rawField
    results = filter ((== subfield) . T.head) subfields

lookupValue :: Text -> Char -> MarcRecordRaw -> Maybe Text
lookupValue aTag subfield record = lookupSubfield entryMetadata subfield record
  where
    entryMetadata = lookupFieldMetadata aTag record

lookupTitle :: MarcRecordRaw -> Maybe Title
lookupTitle = lookupValue titleTag titleSubfield

lookupAuthor :: MarcRecordRaw -> Maybe Author
lookupAuthor = lookupValue authorTag authorSubfield

marcToPairs :: ByteString -> [(Maybe Title, Maybe Author)]
marcToPairs marcStream = zip titles authors
  where
    records = allRecords marcStream
    titles = map lookupTitle records
    authors = map lookupAuthor records

pairsToBooks :: [(Maybe Title, Maybe Author)] -> [Book]
pairsToBooks pairs = map (\(title, author) -> Book { title = fromJust title, author = fromJust author}) justPairs
  where
    justPairs = filter (\(title, author) -> isJust title && isJust author) pairs

processRecords :: Int -> ByteString -> Html
processRecords n = booksToHtml . pairsToBooks . (take n) . marcToPairs

main2 :: IO ()
main2 = do
  marcData <- B.readFile "sample.mrc"
  let processed = processRecords 500 marcData
  TIO.writeFile "books.html" processed