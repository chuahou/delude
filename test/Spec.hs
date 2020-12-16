-- SPDX-License-Identifier: MIT
-- Copyright (c) 2020 Chua Hou

{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}
-- Using lambdas for properties will lead to a *lot* of these warnings that are
-- superfluous.

import           Prelude
import           Test.Hspec
import           Test.QuickCheck

import           Data.List.NonEmpty (NonEmpty (..))

import qualified Delude             as D

-- | @mkprop_Maybe f g xs@ makes sure that a safe version @f@ of a partial
-- function @g@ of type @[Int] -> Maybe a@ will return @Nothing@ on empty
-- lists, and return @Just@ of the same result as @g@ otherwise.
mkprop_Maybe :: Eq a => ([Int] -> Maybe a) -> ([Int] -> a) -> [Int] -> Bool
mkprop_Maybe f g xs = if null xs
                         then f xs == Nothing
                         else f xs == Just (g xs)

mkprop_NE :: (NonEmpty Int -> Int)
          -> (NonEmpty Int -> Int)
          -> NonEmptyList Int -> Bool
mkprop_NE f g (NonEmpty (x:xs)) = f (x:|xs) == g (x:|xs)
mkprop_NE _ _ (NonEmpty [])     = False
    -- this case should not happen thanks to 'NonEmpty'

-- Tests currently only run on 'Int's with until I get around to learning
-- @QuickCheck@ properly.
main :: IO ()
main = hspec $ do
    describe "Delude.foldr1" $ do
        it "is equal for non-empty to foldr1" $ property $
            \(Fn2 f) -> mkprop_Maybe (D.foldr1 f) (foldr1 f)
    describe "Delude.foldl1" $ do
        it "is equal for non-empty to foldl1" $ property $
            \(Fn2 f) -> mkprop_Maybe (D.foldl1 f) (foldl1 f)
    describe "Delude.foldr1'" $ do
        it "is equal on NonEmpty to foldr1" $ property $
            \(Fn2 f) -> mkprop_NE (D.foldr1' f) (foldr1 f)
    describe "Delude.foldl1'" $ do
        it "is equal on NonEmpty to foldl1" $ property $
            \(Fn2 f) -> mkprop_NE (D.foldl1' f) (foldl1 f)
    describe "Delude.maximum" $ do
        it "is equal for non-empty to maximum" $ property $
            mkprop_Maybe D.maximum maximum
    describe "Delude.minimum" $ do
        it "is equal for non-empty to minimum" $ property $
            mkprop_Maybe D.minimum minimum
    describe "Delude.maximum'" $ do
        it "is equal on NonEmpty to maximum" $ property $
            mkprop_NE D.maximum' maximum
    describe "Delude.minimum'" $ do
        it "is equal on NonEmpty to minimum" $ property $
            mkprop_NE D.minimum' minimum
    describe "Delude.sum" $ do
        it "is equal to sum" $ property $ do
            \(xs :: [Int]) -> D.sum xs == sum xs
    describe "Delude.product" $ do
        it "is equal to product" $ property $ do
            \(xs :: [Int]) -> D.product xs == product xs
    describe "Delude.head" $ do
        it "is equal for non-empty to head" $ property $
            mkprop_Maybe D.head head
    describe "Delude.last" $ do
        it "is equal for non-empty to last" $ property $
            mkprop_Maybe D.last last
    describe "Delude.tail" $ do
        it "is equal for non-empty to tail" $ property $
            mkprop_Maybe D.tail tail
    describe "Delude.init" $ do
        it "is equal for non-empty to init" $ property $
            mkprop_Maybe D.init init
    describe "Delude.!?" $ do
        it "is equal when within bounds to !!" $ property $
            \(xs :: [Int]) n -> if n >= 0 && n < length xs
                        then xs D.!? n == Just (xs !! n)
                        else xs D.!? n == Nothing
