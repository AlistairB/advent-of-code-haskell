module Common.Operation.DataLoad where

import Common.Model.Year

readLinesFromFile :: Year -> Text -> IO [Text]
readLinesFromFile year fileName  = do
  let yearAsString = yearToString year
      filePath = "../" <> yearAsString <> "/input/" <> unpack fileName
  contents <- readFileText filePath
  pure $ lines contents
