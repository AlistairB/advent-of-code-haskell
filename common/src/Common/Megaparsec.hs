module Common.Megaparsec
 ( MParser,
   mParseMaybe,
  )
where

import qualified Text.Megaparsec as M

type MParser = M.Parsec Void Text

-- used to avoid the auto parsing of eof by the official parseMaybe
-- https://hackage.haskell.org/package/megaparsec/docs/Text-Megaparsec.html#v:parseMaybe
mParseMaybe :: M.Parsec e s a -> s -> Maybe a
mParseMaybe p = rightToMaybe . M.parse p ""
