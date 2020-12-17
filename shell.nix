let
  pkgs = import ./nix/nixpkgs.nix {};
in
  (pkgs.haskell.lib.overrideCabal (import ./. { inherit pkgs; }) (old: {
    buildTools = (old.buildTools or []) ++ [
      pkgs.haskellPackages.cabal-install
      pkgs.haskellPackages.haskell-language-server
    ];
    doBenchmark = true;
  })).env
