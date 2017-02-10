{ mkDerivation, base, doctest, natural-numbers
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
  license = stdenv.lib.licenses.bsd3;
}
