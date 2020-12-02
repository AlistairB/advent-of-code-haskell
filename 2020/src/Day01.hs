module Day01 where

-- https://adventofcode.com/2020/day/1

import Common.Operation.DataLoad
import Common.Model.Year

input :: IO (Maybe [Int])
input = do
  textLines <- readLinesFromFile Year2020 "Day01.txt"
  pure $
    traverse (readMaybe . unpack) textLines

produceResult :: [Int] -> Maybe Int
produceResult theList =
  head <$> nonEmpty [ i * j | i <- theList, j <- theList, i + j == 2020 ]

run :: IO (Maybe Int)
run = do
  maybeInput <- input
  case maybeInput of
    Just theInput -> pure $ produceResult theInput
    Nothing -> error "Unexpected no input"

produceResult2 :: [Int] -> Maybe Int
produceResult2 theList =
  head <$> nonEmpty [ i * j * k | i <- theList, j <- theList, k <- theList, i + j + k == 2020 ]

run2 :: IO (Maybe Int)
run2 = do
  maybeInput <- input
  case maybeInput of
    Just theInput -> pure $ produceResult2 theInput
    Nothing -> error "Unexpected no input"
