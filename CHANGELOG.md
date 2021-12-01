# Revision history for delude

## 0.1.0.5 -- 2021-12-01

* Change to Nix Flakes instead of classic Nix.
* Update Nixpkgs from 20.09 to 21.11.

## 0.1.0.4 -- 2020-12-22

* Use `filterSource` to prevent noise from entering derivation, for better
  caching.

## 0.1.0.3 -- 2020-12-16

* Added tests.
* Added benchmarks.
* Reorganized nix setup, notably moving hls from default.nix to shell.nix.

## 0.1.0.2 -- 2020-12-15

* Fixed `product`.

## 0.1.0.1 -- 2020-12-15

* Loosened `base` dependency from `^>= 4.13` to `>= 4.13 && < 5`.

## 0.1.0.0 -- 2020-12-15

* First version. Released on an unsuspecting world.
