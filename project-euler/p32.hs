import Data.List

pandigital s    = s `union` nums == s
                where nums = foldl1 (++) $ map show [1..(length s)]

pandigital_prod a b	= length str == 9 && pandigital str
					where str = (show a) ++ (show b) ++ (show (a*b))

pandigital_prods = [a*b | a <- [1..10000], b <- [1..10000], pandigital_prod a b]

result = sum $ nub pandigital_prods

