{-# LANGUAGE OverloadedStrings #-}
module Lesson26 where

import Data.ByteString (ByteString)
import qualified Data.ByteString as B
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import qualified Data.Text.Encoding as E
import Data.Maybe

type Author = Text
type Title = Text

data Book = Book
  { author :: Author
  , title :: Title
  } deriving Show

type Html = Text

bookToHtml :: Book -> Html
bookToHtml book = mconcat
    [ "<p>\n"
    , titleInTags
    , authorInTags
    , "</p>\n"
    ]
  where
    titleInTags  = mconcat [ "<strong>", title book, "</strong>\n" ]
    authorInTags = mconcat [ "<em>", author book, "</em>\n" ]

booksToHtml :: [Book] -> Html
booksToHtml books = mconcat
    [ "<html>\n"
    ,   "<head><title>books</title>"
    , "<meta charset='utf-8'/>"
    , "</head>\n"
    , "<body>\n"
    , booksHtml
    , "\n</body>\n"
    , "</html>"
    ]
  where
    booksHtml = (mconcat . (map bookToHtml)) books

book1, book2, book3 :: Book
book1 = Book "Ligotti, Thomas" "The Conspiracy Against the Human Race"
book2 = Book "Cioran, Emil" "A Short History of Decay"
book3 = Book "Bataille, Georges" "The Tears of Eros"

myBooks :: [Book]
myBooks = [book1, book2, book3]

main :: IO ()
main = TIO.writeFile "books.html" (booksToHtml myBooks)