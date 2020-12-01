module Common.Operation.DataLoad where

import Common.Model.Year
import Data.Text as Text

readLinesFromFile :: Year -> Text -> IO [Text]
readLinesFromFile year fileName  = do
  let yearAsString = yearToString year
      filePath = "../" <> yearAsString <> "/" <> unpack fileName
  contents <- readFile filePath
  pure $ Text.lines $ pack contents
