module Utils where

import           Data.Natural
import           Prelude      (Bool, Int, Maybe (..), Show, String, id, ($),
                               (&&), (+), (-), (.), (<), (>))
import           Types

-- Helpers needed to dealing with the View/Natural encoding of natural numbers
-- These are not needed in Ruby because we only use Integer/Fixnums and basic
-- arithemic operations on them. Because we restrict the values of to being
-- zero or positive to represent natural numbers appropriate, we have some
-- extra work, which - in fairness - should have been provided by the library
-- author, not needing to be written by application developers inside their apps.

decr :: SellIn -> SellIn
decr (Fresh Zero)     = Stale $ view 1
decr (Fresh (Succ n)) = Fresh $ view $ monus n 1
decr (Stale (Succ n)) = Stale $ view $ monus n (-2)

decrVN :: Natural -> View -> View
decrVN n Zero     = Zero
decrVN n (Succ m) = view $ monus (n+m+1) 0

decrV :: View -> View
decrV = decrVN 1

incrVN :: Natural -> View -> View
incrVN n Zero     = Succ n
incrVN n (Succ m) = Succ (n+m)

incrV :: View -> View
incrV = incrVN 1

-- | inclusive range predicate
between :: Natural -> Natural -> Natural -> Bool
between n m p = p > n && p < m

