import Data.List

pandigital a	= s `union` nums == s
				where nums = foldl1 (++) $ map show [1..(length s)]
				      s = show a

primes    = 2: oddprimes
oddprimes = 3: sieve oddprimes 3 0
sieve (p:ps) x k
          = [n | n <- [x+2,x+4..p*p-2]
                 , and [rem n p/=0 | p <- take k oddprimes]]
            ++ sieve ps (p*p) (k+1)

result = [n | n <- primes, pandigital n]
