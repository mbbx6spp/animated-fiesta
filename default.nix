{ bootFetchgit ? (import <nixpkgs> {}).fetchgit, compiler ? "ghc802" }:
let
  pkgs = import (bootFetchgit (import ./version.nix)) {};
  cabalPkg = pkgs.haskell.packages.${compiler}.callPackage ./gilded-rose.nix {};
  #extDeps = with pkgs; [
  #  rt
  #  zlib
  #  gmp
  #  pth
  #  dl
  #];
in cabalPkg // {
  #enableSharedExecutables = true;
  #enableSharedLibraries = false;
  #enableStaticLibraries = true;
  #addBuildDepends = extDeps;
}
