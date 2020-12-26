{ pkgs ? import ./nix/nixpkgs.nix {} }:

let
  src = pkgs.nix-gitignore.gitignoreSource ''
    /.github/
    /.git/
  '' ./.;

in
  builtins.deepSeq
    (builtins.readFile ./package.yaml)
    (pkgs.haskellPackages.callCabal2nix "delude" src {})
