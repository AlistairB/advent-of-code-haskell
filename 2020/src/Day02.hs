module Day02 where

-- https://adventofcode.com/2020/day/1

import Common.Megaparsec
import Common.Model.Year
import Common.Operation.DataLoad
import qualified Text.Megaparsec as M
import qualified Text.Megaparsec.Char as M

input :: IO [Text]
input = do
  readLinesFromFile Year2020 "Day02.txt"

data InvalidatedPassword = InvalidatedPassword
  { _validationRule :: ValidationRule,
    _password :: Text
  }

data ValidationRule = ValidationRule
  { _requiredChar :: Char,
    _atLeast :: Int,
    _atMost :: Int
  }

-- 6-8 s
parserValidationRule :: MParser ValidationRule
parserValidationRule = do
  atLeast <- M.digitChar
  M.char '-'
  atMost <- M.digitChar
  M.hspace
  requiredChar <- M.char
  pure $
    ValidationRule
      { _requiredChar = requiredChar,
        _atLeast = atLeast,
        _atMost = atMost
      }
