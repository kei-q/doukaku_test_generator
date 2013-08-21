{-# LANGUAGE DeriveDataTypeable #-}
module Parser where

import Control.Applicative
import Text.Trifecta

import Text.Hastache
import Text.Hastache.Context
import Data.Text.Lazy (Text)
import Data.Text.Lazy.Encoding (decodeUtf8)
import Data.Data

type Input = String
type Output = String

data Tests = T { tests :: [Test] } deriving (Data, Typeable)
data Test = TD { no :: Int, input :: String, output :: String} deriving (Data, Typeable)

-- parse
-- =============================================================================

parseTestData :: String -> IO (Maybe Tests)
parseTestData = parseFromFile testsP

testsP :: Parser Tests
testsP = do
    ret <- some testP
    return $ T $ map (\(n,(i,o)) -> TD n i o) $ zip [1..] ret

testP :: Parser (Input,Output)
testP = do
    spaces
    commentP
    symbol "test"
    oneOf "("
    spaces
    i <- inputP
    symbol ","
    o <- outputP
    oneOf ")"
    spaces
    skipOptional $ symbolic ';'
    return (i,o)

commentP :: Parser Integer
commentP = do
    symbol "/*"
    skipOptional $ symbolic '#'
    n <- natural
    symbol "*/"
    return n
inputP, outputP :: Parser String
inputP  = enclose '"' $ some (noneOf "\"")
outputP = inputP

enclose :: TokenParsing m => Char -> m a -> m a
enclose c = let c' = symbolic c in between c' c'

-- parse
-- =============================================================================

parseTemplate :: (Data a, Typeable a) => FilePath -> a -> IO Text
parseTemplate path context = decodeUtf8 <$> hastacheFile defaultConfig path (mkGenericContext context)

