digital_sum n	| n > 0 = (n `mod` 10) + digital_sum (n `div` 10)
				| otherwise = 0
