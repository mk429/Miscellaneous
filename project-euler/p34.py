#!/usr/bin/env python

## http://projecteuler.net/index.php?section=problems&id=34 ##
## Find the sum of all numbers which are equal to the sum of the factorial of their digits. ##

fac_table = {}

def fac(n):
	if n in fac_table:
		return fac_table[n]
	res = 1
	for i in range(n):
		res = res * (i + 1)
	fac_table[n] = res
	return res

facs = {
	0: 0,
	1: 1,
	2: 2,
	3: 6,
	4: 24,
	5: 120,
	6: 720,
	7: 5040,
	8: 50320,
	9: 362880
}
def lookup(n):
	return facs[n]

def fac_dig(num):
	n = num
	sum = 0
	while num > 0:
		sum += lookup(n % 10)
		n = n / 10
	return sum

for i in range(3, 1000):
	if fac_dig(i) == i:
		print i

print fac_table
