{-# LANGUAGE NoImplicitPrelude #-}

module Types where

import           Data.Natural (Natural (..), View (..))
import           Prelude      (Bool, Int, Maybe (..), Show, String, id, show,
                               ($), (+), (++), (-), (.), (<), (>))

--  Item = Struct.new(:name, :characterization, :sell_in, :quality)
-- Ruby: 1 line
-- Haskell: 2-5 lines depending on formatting
data Item = Item
  { itemName             :: String
  , itemCharacterization :: Characterization
  , itemSellIn           :: SellIn
  , itemQuality          :: Quality
  }

-- Ruby: 0 lines
-- Haskell: 4 lines
data Characterization = Normal | Vintage | Fleeting | Conjured | Enduring
data SellIn = Fresh View | Stale View
type Quality = View
type Action = Quality -> Quality

-- For purposes of inline testing
instance Show SellIn where
  show (Fresh Zero)     = "Fresh Zero"
  show (Fresh (Succ n)) = "Fresh (Succ " ++ show n ++ ")"
  show (Stale (Succ n)) = "Stale (Succ " ++ show n ++ ")"
  show (Stale Zero)     = "Stale Zero"

-- Again just for doctests to be able to run
instance Show View where
  show Zero     = "Zero"
  show (Succ n) = "Succ " ++ show n
