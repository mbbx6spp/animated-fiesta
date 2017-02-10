module Types where

import           Data.Natural (Natural (..), View (..))
import           Prelude      (Bool, Int, Maybe (..), Show, String, id, ($),
                               (+), (-), (.), (<), (>))

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

