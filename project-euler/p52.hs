import Data.List
result = take 1 $ [x | x <- [1..], ((show x) `union` (show (2*x)) `union` (show (3*x)) `union` (show (4*x)) `union` (show (5*x)) `union` (show (6*x))) == (show x)]
