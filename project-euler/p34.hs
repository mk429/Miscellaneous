{-
 - 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
 - Find the sum of all numbers which are equal to the sum of the factorial of their digits.
 - Note: as 1! = 1 and 2! = 2 are not sums they are not included
 - 
 -}

fact =
	let fact' 0 = 1
	    fact' 1 = 1
	    fact' n = n * (fact' $ n -1)
	in  (map fact' [0..] !!)

digits = reverse . digits'
digits' n | n > 0		= (n `mod` 10):(digits' $ n `div` 10)
          | otherwise	= []

sum_facts n = sum $ map fact (digits n)

facts_with_index n = zip [1..n] (map sum_facts [1..n])

equal_fact_sums n = map fst $ filter (\(x,y) -> x == y) (facts_with_index n)

