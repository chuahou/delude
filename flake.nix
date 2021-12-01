# SPDX-License-Identifier: MIT
# Copyright (c) 2021 Chua Hou

{
  inputs.nixpkgs.url = "nixpkgs/nixos-21.11";

  outputs = inputs@{ nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

  in rec {
    defaultPackage.${system} = pkgs.haskellPackages.callCabal2nix "delude" ./. {};

    devShell.${system} =
      (pkgs.haskell.lib.overrideCabal defaultPackage.${system} (old: {
        buildTools = (old.buildTools or []) ++ [
          pkgs.haskellPackages.cabal-install
        ];
        doBenchmark = true;
      })).env;
  };
}
