
pentagonal n = n * ((3 * n) - 1) `div` 2

pentagonals	= pentagonals' 1
			where pentagonals' n = (pentagonal n):(pentagonals' (n+1))

{-
is_pentagonal n	= check_pent n 1
check_pent n t	| p > n		= False
				| p == n	= True
				| otherwise	= check_pent n (t+1)
				where p = pentagonal t
-}
is_pentagonal :: Integer -> Bool
is_pentagonal n	| n < 0 = is_pentagonal (-n)
				| otherwise = ceiling x == floor x
				where x = (((sqrt ((24.0 * l) + 1.0)) + 1.0)) / 6.0
				      l = fromInteger n :: Float

results n	= [(a,b) | a <- n_pents, b <- n_pents, is_pentagonal (a+b), is_pentagonal (b-a)]
			where n_pents = take n pentagonals

