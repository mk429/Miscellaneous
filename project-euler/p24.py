#!/usr/bin/env python

## http://projecteuler.net/index.php?section=problems&id=24 ##
## What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9? ##

"""
Instead of a straight-forward lexical permutation
algorithm, I chose to solve this problem by writing
a function to get the factoradic representation of
the required iteration, and use this to easily
generate that permutation. Once the factoradic is
known, we simply use each digit of the factoradic
as an index into the symbol string, add the symbol
at that index to the result string, and remove that
element.
--mk429
"""

factorial_table = {0:1, 1:1}

def factorial(n):
	if n in factorial_table:
		return factorial_table[n]
	fac = n * factorial(n - 1)
	factorial_table[n] = fac
	return fac

def factoradic(n):
	s = ''
	t = 0
	while factorial(t+1) <= n:
		t += 1
	for i in range(t, -1, -1):
		m = 0
		while m <= i and (m+1) * factorial(i) <= n:	
			m += 1
		s += str(m)
		n -= m * factorial(i)
	return s

def get_perm(f, s):
	"""get the permutation indexed by factoradic f with symbols in string s"""
	ret = ''
	for i in range(len(s) - len(f)):
		ret += s[0]
		s = s[1:]
	for i in range(len(f)):
		p = int(f[i])
		ret += s[p]
		s = s[:p] + s[p+1:]
	return ret

"""Get the millionth permutation of 0123456789"""
print "millionth perm is", get_perm(factoradic(999999), '0123456789')
