#!/usr/bin/env python

## http://projecteuler.net/index.php?section=problems&id=18 ##
## Find the maximum total from top to bottom of the triangle below ##
from math import sqrt, floor

class NumberTriangle:
	"""class representing triangular numbers"""
	
	values = []
	def __len__(self):
		return int(sqrt(2 * len(self.values)))

	def load(self, file):
		f = open(file, 'r')
		lines = f.readlines()
		for line in lines:
			for n in line.split(' '):
				self.values.append(int(n))

	def row_at(self, n):
		start = (n) * (n + 1) / 2
		end = (n + 1) * (n + 2) / 2
		return self.values[start : end]

	def t_print(self):
		for i in range(0, len(self)):
			print self.row_at(i)

	def max_path_sum(self):
		return self.max_path(len(self) - 2, self.row_at(len(self) - 1))

	def max_path(self, row_num, prev_weights):
		print prev_weights
		if row_num < 0:
			return prev_weights[0]
		curr_weights = []
		row = self.row_at(row_num)
		for i in range(0, len(row)):
			if prev_weights[i] > prev_weights[i+1]:
				curr_weights.append(prev_weights[i] + row[i])
			else:
				curr_weights.append(prev_weights[i+1] + row[i])
		return self.max_path(row_num - 1, curr_weights)


nt = NumberTriangle()
nt.load("t.txt")
nt.t_print()

print "attempting to find path..."
print nt.max_path_sum()
