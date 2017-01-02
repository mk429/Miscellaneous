#!/usr/bin/env python

## http://projecteuler.net/index.php?section=problems&id=23 ##
## Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers. ##

from math import sqrt

abundant = []
#factors = {}
#
#def get_factors(n):
#	print "get factors of", n
#	if n in factors:
#		return factors[n]
#	fac_list = []
#	if n != 1:
#		fac_list.append(n) # n is a factor of n for all n
#	consider = [i for i in reversed(range(2, n))]
#	for i in consider:
#		print "to be considered:", consider
#		print "considering", i
#		if n % i == 0:
#			print "it's a factor, and",
#			if i in factors:
#				print "we've seen this before"
#				for f in factors[i]:
#					fac_list.append(f)
#					if f in consider:
#						consider.remove(f)
#			else:
#				print "it's new!"
#				fac_list.append(i)
#	if 1 not in fac_list:
#		fac_list.append(1) # 1 is a factor of everything
#	factors[n] = fac_list
#	return fac_list

# factorise(n) - returns a list of factors of n #
def factorise(n):
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
	prev_nums[n] = fac_list
        return fac_list

prev_nums = {}

for i in range(1, 28124):
	factors = factorise(i)
	print prev_nums
	abundant.append(sum(factors))
abundant
