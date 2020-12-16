-- SPDX-License-Identifier: MIT
-- Copyright (c) 2020 Chua Hou

import           Criterion.Main

import           Data.List.NonEmpty (NonEmpty (..))

import qualified Delude             as D
import           Prelude

comparison :: String -> (a -> b) -> (a -> b) -> a -> Benchmark
comparison name df pf x =
    bgroup ("Comparison of " <> name)
        [ bench "Delude"  $ whnf df x
        , bench "Prelude" $ whnf pf x
        ]

main :: IO ()
main = defaultMain
    [ comparison "foldr1"   (D.foldr1 (+))  (Just . foldr1 (+)) million
    , comparison "foldl1"   (D.foldl1 (+))  (Just . foldl1 (+)) million
    , comparison "foldr1'"  (D.foldr1' (+)) (foldr1 (+))        neMillion
    , comparison "foldl1'"  (D.foldl1' (+)) (foldl1 (+))        neMillion
    , comparison "maximum"  D.maximum       (Just . maximum)    million
    , comparison "minimum"  D.minimum       (Just . minimum)    million
    , comparison "maximum'" D.maximum'      maximum             neMillion
    , comparison "minimum'" D.minimum'      minimum             neMillion
    , comparison "sum"      D.sum           sum                 million
    , comparison "product"  D.product       product             million
    , comparison "head"     D.head          (Just . head)       million
    , comparison "last"     D.last          (Just . last)       million
    , comparison "tail"     D.tail          (Just . tail)       million
    , comparison "init"     D.init          (Just . init)       million
    , comparison "!?vs!!"   (D.!? index)    (Just . (!! index)) million
    ]
    where
        million   = [1..1000000] :: [Int]
        neMillion = 1:|[2..1000000] :: NonEmpty Int
        index     = 678901
