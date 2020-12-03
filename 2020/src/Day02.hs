module Day02 where

-- https://adventofcode.com/2020/day/1

import Common.Megaparsec
import Common.Model.Year
import Common.Operation.DataLoad
import qualified Text.Megaparsec as M
import qualified Text.Megaparsec.Char as M
import qualified Data.Text as T

input :: IO [Text]
input = do
  readLinesFromFile Year2020 "Day02.txt"

data UnvalidatedPassword = UnvalidatedPassword
  { _validationRule :: ValidationRule,
    _password :: Text
  }
  deriving Generic

data ValidationRule = ValidationRule
  { _requiredChar :: Char,
    _atLeast :: Int,
    _atMost :: Int
  }
  deriving Generic

run :: IO (Maybe Int)
run = do
  textInput <- input
  pure $
    produceResult textInput


produceResult :: [Text] -> Maybe Int
produceResult theList =
  let maybeParsedPasswords = for theList parseUnvalidatedPassword
  in
    maybeParsedPasswords <&>
      length . filter (== True) . fmap validatePassword


validatePassword :: UnvalidatedPassword -> Bool
validatePassword up =
  let vr = up ^. #_validationRule
      password = up ^. #_password
      requiredChar = vr ^. #_requiredChar
      atLeast = vr ^. #_atLeast
      atMost = vr ^. #_atMost
      numRequiredChar = T.length $ T.filter (== requiredChar) password
  in
    numRequiredChar >= atLeast && numRequiredChar <= atMost



parseUnvalidatedPassword :: Text -> Maybe UnvalidatedPassword
parseUnvalidatedPassword = mParseMaybe parserUnvalidatedPassword

-- 6-8 s: svsssszslpsp
parserUnvalidatedPassword :: MParser UnvalidatedPassword
parserUnvalidatedPassword = do
  validationRule <- parserValidationRule
  M.char ':' *> M.hspace
  password <- pack <$> M.some M.lowerChar
  pure $
    UnvalidatedPassword
      { _validationRule = validationRule,
        _password = password
      }


-- 6-8 s
parserValidationRule :: MParser ValidationRule
parserValidationRule = do
  maybeAtLeast <- readMaybe <$> M.some M.digitChar
  M.char '-'
  maybeAtMost <- readMaybe <$> M.some M.digitChar
  M.hspace
  requiredChar <- M.lowerChar
  case (maybeAtLeast, maybeAtMost) of
    (Just atLeast, Just atMost) ->
        pure $
          ValidationRule
            { _requiredChar = requiredChar,
              _atLeast = atLeast,
              _atMost = atMost
            }
    _ -> fail "atLeast or atMost were not a digit"
