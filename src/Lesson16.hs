module Lesson16 where

data AuthorName
  = AuthorName String String

data Book = Book
  { author :: Creator
  , isbn   :: String
  , bookTitle  :: String
  , bookYear   :: Int
  , bookPrice  :: Double
  }

data VinylRecord = VinylRecord
  { artist      :: Creator
  , recordTitle :: String
  , recordYear  :: Int
  , recordPrice :: Double
  }

type FirstName = String
type LastName = String
type MiddleName = String

data Name
  = Name FirstName LastName
  | NameWithMiddle FirstName MiddleName LastName
  | TwoInitialsWithLast Char Char LastName
  | FirstNameWithTwoInits FirstName Char Char

data Creator
  = AuthorCreator Author
  | ArtistCreator Artist

data Author
  = Author Name

data Artist
  = Person Name
  | Band String

hpLovecraft :: Creator
hpLovecraft = AuthorCreator (Author (TwoInitialsWithLast 'H' 'P' "Lovecraft"))

data StoreItem
  = BookItem Book
  | RecordItem VinylRecord
  | ToyItem CollectibleToy

data CollectibleToy = CollectibleToy
  { name        :: String
  , description :: String
  , toyPrice    :: Double
  }

price :: StoreItem -> Double
price (BookItem book) = bookPrice book
price (RecordItem record) = recordPrice record
price (ToyItem toy) = toyPrice toy