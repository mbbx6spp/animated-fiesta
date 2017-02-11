{ mkDerivation, base, doctest, doctest-discover, natural-numbers
, optparse-applicative, QuickCheck, stdenv
}:
mkDerivation {
  pname = "gilded-rose";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base doctest natural-numbers QuickCheck
  ];
  executableHaskellDepends = [ base optparse-applicative ];
  testHaskellDepends = [ base doctest doctest-discover ];
  license = stdenv.lib.licenses.bsd3;
}
