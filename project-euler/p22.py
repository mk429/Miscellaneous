#!/usr/bin/env python

## http://projecteuler.net/index.php?section=problems&id=22 ##
## What is the total of all the name scores in the file? ##

file = open("names.txt", "r")
lines = file.readline().split('","')
lines = map(lambda x: x.strip('\r\n'), lines)
nums = [[ord(c) - ord('A') + 1 for c in l] for l in lines]
sorted_nums = sorted(nums)
total = 0
for i in range(len(sorted_nums)):
	total += (i+1) * sum(sorted_nums[i])

print sorted_nums
print "total: ", total
