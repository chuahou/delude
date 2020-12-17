{ pkgs ? import ./nix/nixpkgs.nix {} }:

pkgs.haskellPackages.callCabal2nix "delude" ./. {}
