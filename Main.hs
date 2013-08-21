{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
import Web.Scotty
import Network.HTTP.Types (notFound404)
import Control.Monad.IO.Class (liftIO)
import qualified Control.Exception as E (catch, SomeException)

import Parser

r404 :: ActionM ()
r404 = do
    status notFound404
    text "404"

main :: IO ()
main = scotty 3001 $ do
    get "/:qid/:format" $ \qid format -> do
        ret <- liftIO $ do
            a <- parseTestData $ "testdata/" ++ qid ++ ".txt"
            case a of
                (Just td) -> do
                    r <- parseTemplate ("template/" ++ format ++ ".tpl") td
                    return $ Just r
                _ -> return Nothing
            `E.catch` \(_::E.SomeException) -> return Nothing
        case ret of
            Nothing -> r404
            Just r -> text r

