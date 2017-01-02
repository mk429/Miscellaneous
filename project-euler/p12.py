#!/usr/bin/env python

## What is the value of the first triangle number to have over five hundred divisors?
## http://projecteuler.net/index.php?section=problems&id=12

import sys
from math import sqrt

if len(sys.argv) < 3:
	print "usage: ", sys.argv[0], " start end [quiet]"
	sys.exit(1)

updates = True
if len(sys.argv) > 3:
	updates = False

# t(tnum, i) - returns the next triangular number #
def t(tnum, i):
	i = i + 1
	tnum = tnum + i
	return tnum, i

# factorise(n) - returns a list of factors of n #
def factorise(n, prev_nums):
	if n < 2:
		return [1]
	lim = int(sqrt(n))
	factors = dict([(i, False) for i in range(2, lim + 1)]) # nothing is a factor yet
	factors[1] = True # 1 is a factor of everything, bar 0
	factors[n] = True
	f_keys = factors.keys()
	f_keys.sort(reverse=True)
	for i in f_keys:
		if factors[i]:
			continue
		elif (n % i == 0):
			if i in prev_nums.keys():
				for j in prev_nums[i]:
					factors[j] = True
			else:
				factors[i] = (n % i == 0)
	fac_list = []
	for i in factors.keys():
		if factors[i]:
			fac_list.append(i)
	return fac_list

n = int(sys.argv[1])
end = int(sys.argv[2])

print "Searching for a triangular number with over 500 factors"
print "Checking triangle numbers from T[", n, "] - T[", (end - 1), "]"

factors = {}
max = 0
index = n
curr_t = n * (n + 1) / 2

for i in range(n, end):
	factors[curr_t] = factorise(curr_t, factors)
	
	if len(factors[curr_t]) > max:
		max = len(factors[curr_t])
		print "T[", i, "]:", curr_t, " - max found: ", max
	
	if updates:
		print "T[", i, "]: ", curr_t, " has ", len(factors[curr_t]), " factors"
		print factors[curr_t] # this generates a LOT of output!
	
	if len(factors[curr_t]) > 500:
		print "Finished! ", curr_t, " has ", len(factors[curr_t]), " divisors."
		break
	curr_t,index = t(curr_t, index)
