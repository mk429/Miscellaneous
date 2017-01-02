#!/usr/bin/env python

## http://projecteuler.net/index.php?section=problems&id=35 ##
## How many circular primes are there below one million? ##

primes = []
def is_prime(n):
	prime = True
	for p in primes:
		if n % p == 0:
			prime = False
			break
	if prime:
		primes.append(n)
	return prime

for i in range(2, 1000000):
	is_prime(i)
