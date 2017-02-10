# Gilded Rose

I took [@onethirtyfive](https://github.com/onethirtyfive/gildedrosekata)'s
ending Ruby implementation of the Gilded Rose Refactoring kata and did a
super _dumb_ port, only added types where it made sense (nothing else).

## Next Steps

TODO:

* Rewrite straight port to use more generic functions, typeclasses where relevant.
* Add more type constraints to enforce constraints where useful
* Clean up and organize code better
* Write case-based and property-based tests for the problem

## Starting Point

* [GildedRose.hs](src/GildedRose.hs) - contains the ported application logic
* [Types.hs](src/Types.hs) - contains type definitions for the project
* [Utils.hs](src/Utils.hs) - contains functions that shouldn't have been needed
  but the natural number representation didn't have these in the library that
  I could see
