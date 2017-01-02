{-
 - The number 3797 has an interesting property. Being prime itself,
 - it is possible to continuously remove digits from left to right,
 - and remain prime at each stage: 3797, 797, 97, and 7. Similarly
 - we can work from right to left: 3797, 379, 37, and 3.
 -
 - Find the sum of the only eleven primes that are both truncatable from left to right and right to left.
 -
 - NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
 -
 -}

{-
primes_up_to n = primes_up_to' [2..n]
primes_up_to' [] = []
primes_up_to' (c:candidates) = c:(primes_up_to' [n | n <- candidates, n `mod` c /= 0])
-}

{-
primes = 2:(primes' [2])
primes' known_primes	= new_prime:(primes' (new_prime:known_primes))
				where new_prime = next_prime' ((head known_primes) + 1) known_primes

next_prime' candidate primes	| [n | n <- primes, candidate `mod` n == 0] == [] = candidate
								| otherwise = next_prime' (candidate + 1) primes
-}

primes    = 2: oddprimes
oddprimes = 3: sieve oddprimes 3 0
sieve (p:ps) x k 
          = [n | n <- [x+2,x+4..p*p-2]
                 , and [rem n p/=0 | p <- take k oddprimes]]
            ++ sieve ps (p*p) (k+1)

is_prime n = is_prime' n 0
is_prime' n i	| curr >  n = False
				| curr <  n = is_prime' n (i + 1)
				| curr == n = True
				where curr = primes !! i

truncatable n p	= left_truncatable' (show n) calc_primes && right_truncatable' (show n) calc_primes
				where calc_primes = take p primes

left_truncatable' [] _ = True
left_truncatable' n calc_primes	| (read n :: Int) `elem` calc_primes = left_truncatable' (tail n) calc_primes
								| otherwise  = False

right_truncatable' [] _ = True
right_truncatable' n calc_primes	| (read n :: Int) `elem` calc_primes = right_truncatable' (init n) calc_primes
									| otherwise = False

main :: IO ()
main = do
	let calc_primes = take 100000 primes
	let r = drop 4 $ take 15 [n | n <- calc_primes, left_truncatable' (show n) calc_primes && right_truncatable' (show n) calc_primes]
	putStrLn $ "Result: " ++ (show $ sum r)

