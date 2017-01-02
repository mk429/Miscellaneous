#!/usr/bin/env python

## http://projecteuler.net/index.php?section=problems&id=21 ##
## Evaluate the sum of all the amicable numbers under 10000. ##

import signal, os
from time import sleep

divisor_table = {}

def divisors(n, divisor_table):
	if n in divisor_table:
		return divisor_table[n]
	divisors = set()
	nums = [x for x in reversed(range(1, (n / 2) + 1))]
	for i in nums:
		if i in divisor_table and n % i == 0:
			divisors = divisors | divisor_table[i] | set([i])
			nums =  [x for x in nums if x not in divisor_table[i]]
		elif n % i == 0:
				divisors = divisors | set([i])
	divisor_table[n] = divisors
	return divisors

def d(n, divisor_table):
	return sum(divisors(n, divisor_table))

def quitting(signum, frame):
	print "quitting with sum = ", s
	exit(1)

s = 0
signal.signal(signal.SIGINT, quitting)
summed = []
for a in range(1, 10000):
	b = d(a, divisor_table)
	if b not in summed and a != b and a == d(b, divisor_table):
		print "pair ", a, " and ", b
		s += a + b
		summed.append(a)
	if a % 75 == 0:
		t = a / 250
		print "sleeping ", t, " secs at ", a
		sleep(t)
print
print "total: ", s
