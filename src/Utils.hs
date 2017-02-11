{-# LANGUAGE NoImplicitPrelude #-}

module Utils where

import           Data.Natural
import           Prelude      (Bool, Int, Maybe (..), Show, String, id, ($),
                               (&&), (+), (-), (.), (<), (<=), (>), (>=))
import           Types

-- Helpers needed to dealing with the View/Natural encoding of natural numbers
-- These are not needed in Ruby because we only use Integer/Fixnums and basic
-- arithemic operations on them. Because we restrict the values of to being
-- zero or positive to represent natural numbers appropriate, we have some
-- extra work, which - in fairness - should have been provided by the library
-- author, not needing to be written by application developers inside their apps.

-- | Decrement the SellIn value
--
-- Examples:
--
-- >>> decr $ Fresh Zero
-- Stale Zero
--
-- >>> decr $ Stale (Succ 2)
-- Stale (Succ 3)
decr :: SellIn -> SellIn
decr (Fresh Zero)     = Stale Zero
decr (Fresh (Succ n)) = Fresh $ view n
decr (Stale (Succ n)) = Stale $ view $ monus (n+2) 0

-- | Decrement by N given a starting point
--
-- Examples:
--
-- >>> decrVN 2 $ Succ 7
-- Succ 5
--
-- >> decrVN 5 $ Succ 12
-- Succ 7
--
-- >> decrVN 2 $ Succ 1
-- Zero
decrVN :: Natural -> View -> View
decrVN n Zero     = Zero
decrVN n (Succ m) = view $ monus (m+1) n

decrV :: View -> View
decrV = decrVN 1

-- | Increment by N given a starting point
--
-- Examples:
--
-- >>> incrVN 5 (Succ 1)
-- Succ 6
--
-- >>> incrVN 1 Zero
-- Succ 1
incrVN :: Natural -> View -> View
incrVN n Zero     = Succ n
incrVN n (Succ m) = Succ (n+m)

incrV :: View -> View
incrV = incrVN 1

-- | Inclusive range predicate
--
-- Examples:
--
-- >>> between 0 4 5
-- False
--
-- >>> between 10 20 18
-- True
--
-- >>> between 0 5 0
-- True
--
-- >>> between 0 5 5
-- True
--
-- >>> between 1 5 0
-- False
between :: Natural -> Natural -> Natural -> Bool
between n m p = p >= n && p <= m

