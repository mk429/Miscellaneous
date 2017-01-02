{-
 -  A perfect number is a number for which the sum of its proper divisors is exactly equal to the number.
 -  For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that
 -  28 is a perfect number.
 -
 -  A number n is called deficient if the sum of its proper divisors is less than n and it is called
 -  abundant if this sum exceeds n.
 -
 -  As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written
 -  as the sum of two abundant numbers is 24. By mathematical analysis, it can be shown that all integers
 -  greater than 28123 can be written as the sum of two abundant numbers. However, this upper limit cannot
 -  be reduced any further by analysis even though it is known that the greatest number that cannot be
 -  expressed as the sum of two abundant numbers is less than this limit.
 -
 -  Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.
 -
 -}

import Data.List

-- Find the factors of a number
factors n | n > 0 = 1:(factors' n candidates)
	where candidates =  [2..(n `div` 2)]

factors' n [] = []
factors' n (x:xs)	| n `mod` x == 0 = x:(factors' n xs)
					| otherwise = factors' n xs

-- Find the type of a number
data PerfectType = Perfect | Deficient | Abundant
	deriving (Show, Eq)

number_type n	| n < s 	= Abundant
				| n == s	= Perfect
				| n > s		= Deficient
				where s = sum $ factors n

-- Find abundant numbers less than or equal to n
abundant n = [i | i <- [1..n], number_type i == Abundant]

-- Find if n is the sum of two numbers from nums
is_sum_of_two n nums = is_sum_of_two' n nums nums
is_sum_of_two' _ [] _ = False
is_sum_of_two' n (x:xs) nums | n > x && diff `elem` nums = True
							 | otherwise = is_sum_of_two' n xs nums
							 where diff = n - x

-- Find the sum of all positive integers which cannot be written as the sum of two abundant numbers
sum_of_abundants = sum nonabundantsums
				   where nonabundantsums = [n | n <- [1..28123], not $ is_sum_of_two n abundants]
				         abundants = abundant 28123

main :: IO ()
main = 	do
			--let result = sum_of_abundants
			let abundants = abundant 28123
			putStrLn "Calculated abundants"
			let nonabundantsums = [n | n <- [1..28123], not $ is_sum_of_two n abundants]
			putStrLn "Calculated non-abundant sums"
			let result = sum nonabundantsums
			putStrLn $ "Result: " ++ (show result)
		
