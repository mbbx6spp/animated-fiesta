module GildedRose where

import           Data.Natural
import           Prelude      (Bool, Int, Maybe (..), Show, String, id, ($),
                               (+), (-), (.), (<), (>))
import           Types
import           Utils        (between, decr, decrV, decrVN, incrV, incrVN)

--   def next_sell_in(characterization, sell_in)
--     case characterization
--     when :normal, :vintage, :fleeting, :conjured; sell_in - 1
--     when :enduring;                               sell_in
--     else
--       raise "unknown characterization: #{characterization}"
--     end
--   end
-- Ruby: ~8 lines
-- Haskell: 3 lines (including type signature)
nextSellIn :: Characterization -> SellIn -> SellIn
nextSellIn Enduring s = s
nextSellIn _ s        = decr s

--   def derive_quality_action(characterization, sell_in, quality)
--     case characterization
--     when :normal;   sell_in < 0 ? [:-, 2] : [:-, 1]
--     when :conjured; sell_in < 0 ? [:-, 4] : [:-, 2]
--     when :vintage;  sell_in < 0 ? [:+, 2] : [:+, 1]
--     when :enduring; [:_, quality]
--     when :fleeting
--       case sell_in
--       when (0..4);     [:+, 3]
--       when (5..9);     [:+, 2]
--       when (10..365);  [:+, 1] # only support new inventory for one year
--       when (-365..-1); [:_, 0] # only support old inventory for one year
--       else
--         raise "sell_in value #{sell_in} out of range"
--       end
--     else
--       raise "unknown characterization: #{characterization}"
--     end
--   end
-- Ruby: ~19 lines
-- Haskell: 9 linues (including type signature)
deriveQualityAction :: Characterization -> SellIn -> (Quality -> Quality)
deriveQualityAction Enduring _                = id
deriveQualityAction Normal _                  = decrVN 2
deriveQualityAction Normal _                  = decrVN 4
deriveQualityAction Vintage (Stale _)         = incrV
deriveQualityAction Fleeting (Fresh Zero)     = incrVN 3
deriveQualityAction Fleeting (Fresh (Succ n)) | between 1 4 (n+1) = incrVN 3
deriveQualityAction Fleeting (Fresh (Succ n)) | between 5 9 (n+1) = incrVN 2
deriveQualityAction Fleeting (Fresh (Succ n)) | between 10 365 (n+1) = incrV
deriveQualityAction Fleeting (Stale _)        = id

--   def apply_quality_action(action, quality)
--     op, value = *action
--     case op
--     when :+; quality + value
--     when :-; quality - value
--     when :_; value
--     else
--       raise "unknown op: #{op}"
--     end
--   end
-- Ruby: ~10 lines
-- Haskell: 2 lines (including type signature)
applyQualityAction :: Action -> Quality -> Quality
applyQualityAction f q = f q

--   def apply_quality_ceiling(characterization, quality)
--     case characterization
--     when :normal, :fleeting, :vintage, :conjured; [quality, 50].min
--     when :enduring;                               quality
--     else
--       raise "unknown characterization: #{characterization}"
--     end
--   end
-- module_function :apply_quality_ceiling
-- THIS IS NOT NECESSARY IN HASKELL since we chose to represent Quality type
-- in a "natural number" representation.
-- Ruby: ~8 lines
-- Haskell: 0 lines (or lines for extra type definitions)

--  def apply_quality_floor(characterization, quality)
--    case characterization
--    when :normal, :fleeting, :vintage, :conjured; [quality, 0].max
--    when :enduring;                               quality
--    else
--      raise "unknown characterization: #{characterization}"
--    end
--  end
--  module_function :apply_quality_floor
-- THIS IS NOT NECESSARY IN HASKELL since we chose to represent Quality type
-- in a "natural number" representation. It isn't possible to construct a
-- value of the type `View` as a negative number.
-- Ruby: ~8 lines
-- Haskell: 0 lines (or lines for extra type definitions)

--  def tick(item)
--    name, characterization, sell_in, quality = *item
--
--    sell_in = next_sell_in(characterization, sell_in)
--    quality =
--      apply_quality_action(
--        derive_quality_action(characterization, sell_in, quality),
--        quality
--      )
--    quality = apply_quality_ceiling(characterization, quality)
--    quality = apply_quality_floor(characterization, quality)
--
--    Item.new(name, characterization, sell_in, quality)
--  end
-- Ruby: ~11 lines
-- Haskell: 4 lines
tick :: Item -> Item
tick (Item n c s q) = Item n c newSellIn newQuality
  where newQuality = applyQualityAction (deriveQualityAction c s) q
        newSellIn = nextSellIn c s
