-- SPDX-License-Identifier: MIT
-- Copyright (c) 2020 Chua Hou

-----------------------------------------------------------------------------
-- |
-- Module      : Delude
-- Copyright   : Chua Hou 2020
-- License     : MIT
--
-- Maintainer  : Chua Hou <human+github@chuahou.dev>
-- Stability   : experimental
-- Portability : non-portable
--
-- A simple @Prelude@ replacement, aiming to bring unsafe partial functions out
-- of scope, and bring in replacements work as suitable replacements, such as
-- @readMaybe@ instead of @read@, and @head@/@tail@ that return @Maybe@ values.
-----------------------------------------------------------------------------

module Delude (
              -- * Rewritten functions
                foldr1
              , foldl1
              , foldr1'
              , foldl1'
              , maximum
              , minimum
              , maximum'
              , minimum'
              , sum
              , product
              -- * Non-@Prelude@ reexports
              -- ** 'Data.Foldable'
              , module Data.Foldable
              -- * Original @Prelude@ reexports
              , module Prelude
              ) where

import           Data.Foldable      (foldl')
import           Data.List.NonEmpty (NonEmpty (..))
import           Prelude            hiding (foldl1, foldr1, maximum, minimum,
                                     product, sum)
import qualified Prelude

-- | A variant of 'foldr' that has no base case, that when applied to an empty
-- structure, returns 'Nothing'.
foldr1 :: Foldable t => (a -> a -> a) -> t a -> Maybe a
foldr1 f = foldr mf Nothing
    where
        mf x Nothing  = Just x
        mf x (Just y) = Just (f x y)

-- | A variant of 'foldl' that has no base case, that when applied to an empty
-- structure, returns 'Nothing'.
foldl1 :: Foldable t => (a -> a -> a) -> t a -> Maybe a
foldl1 f = foldl mf Nothing
    where
        mf Nothing  x = Just x
        mf (Just y) x = Just (f y x)

-- | 'Prelude.foldr1' applied to a 'NonEmpty' list, guaranteeing no error is
-- thrown.
foldr1' :: (a -> a -> a) -> NonEmpty a -> a
foldr1' = Prelude.foldr1

-- | 'Prelude.foldl1' applied to a 'NonEmpty' list, guaranteeing no error is
-- thrown.
foldl1' :: (a -> a -> a) -> NonEmpty a -> a
foldl1' = Prelude.foldl1

-- | The largest element of a structure. Returns 'Nothing' when applied to an
-- empty structure.
maximum :: (Foldable t, Ord a) => t a -> Maybe a
maximum = foldl1 max

-- | The smallest element of a structure. Returns 'Nothing' when applied to an
-- empty structure.
minimum :: (Foldable t, Ord a) => t a -> Maybe a
minimum = foldl1 min

-- | 'Prelude.maximum' applied to a 'NonEmpty' list, guaranteeing no error is
-- thrown.
maximum' :: (Ord a) => NonEmpty a -> a
maximum' = Prelude.maximum

-- | 'Prelude.minimum' applied to a 'NonEmpty' list, guaranteeing no error is
-- thrown.
minimum' :: (Ord a) => NonEmpty a -> a
minimum' = Prelude.minimum

-- | 'Prelude.sum' but with strict 'foldl'' for better performance.
sum :: (Foldable t, Num a) => t a -> a
sum = foldl' (+) 0

-- | 'Prelude.product' but with strict 'foldl'' for better performance.
product :: (Foldable t, Num a) => t a -> a
product = foldl' (*) 0
