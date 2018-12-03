module Day01 where


main :: IO ()
main = do
  numberOperations <- readNumberOperations
  print $ foldr (processAdjustment) 0 numberOperations

processAdjustment :: AdjustOperation -> Int -> Int
processAdjustment (Add adjust) current = current + adjust
processAdjustment (Subtract adjust) current = current - adjust

data AdjustOperation =  Add Int | Subtract Int

parseOperation :: String -> AdjustOperation
parseOperation ('+':number) = Add (read number)
parseOperation ('-':number) = Subtract (read number)

readNumberOperations :: IO [AdjustOperation]
readNumberOperations = do
  contents <- readFile "input/01.txt"
  pure $ fmap parseOperation $ lines $ contents

