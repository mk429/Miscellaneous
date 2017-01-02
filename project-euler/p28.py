#!/usr/bin/env python

## http://projecteuler.net/index.php?section=problems&id=48 ##
## Find the last ten digits of the series, 1^(1) + 2^(2) + 3^(3) + ... + 1000^(1000) ##

sum = 0
for n in range(1, 1000):
	print n, "^(", n, ") + ",
	sum += n**n
n += 1
print n, "^(", n, ")"
sum += n**n

print "sum: ", sum
print "last ten digits: ", str(sum)[-10:]
