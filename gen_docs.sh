#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# Copyright (c) 2020 Chua Hou
#
# Generate Haddock docs and copy to docs/ folder for GitHub pages.

cabal haddock --haddock-hyperlink-source
rm docs/ -rf
cp dist-newstyle/build/x86_64-linux/ghc-*/delude-*/doc/html/delude -r docs
