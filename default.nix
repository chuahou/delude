{ pkgs ? import ./nix/nixpkgs.nix {} }:

let
  delude = pkgs.haskellPackages.callCabal2nix "delude" ./. {};
in
  pkgs.haskell.lib.overrideCabal delude (old: {
    buildTools = (old.buildTools or []) ++ [
      pkgs.haskellPackages.cabal-install
    ];
  })
