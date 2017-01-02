#!/usr/bin/env python

## http://projecteuler.net/index.php?section=problems&id=25 ##
## What is the first term in the Fibonacci sequence to contain 1000 digits? ##

import math

def fib(n, fibs):
	print "called fib(", n, ")"
	fn1 = 0
	fn2 = 0
	if (n - 1) in fibs:
		fn1 = fibs[n - 1]
	else:
		fn1 = fib(n - 1, fibs)
	if (n - 2) in fibs:
		fn2 = fibs[n - 2]
	else:
		fn2 = fib(n - 2, fibs)
	fibs[n] = fn1 + fn2
	return fibs[n]

fibs = { 1: 1, 2: 1 }

res = 1
n = 2
while math.floor(math.log10(res)) + 1 < 1000:
	n = n + 1
	res = fib(n, fibs)

print n, " is the first term with 1000+ digits"
