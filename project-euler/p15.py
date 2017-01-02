#!/usr/bin/env python

## How many routes are there through a 20x20 grid? ##
## http://projecteuler.net/index.php?section=problems&id=15 ##

def num_paths(x, y, grid_x, grid_y):
	if x == grid_x and y == grid_y:
		return 1
	res = 0
	if x < grid_x:
		res = res + num_paths(x + 1, y, grid_x, grid_y)
	if y < grid_y:
		res = res + num_paths(x, y + 1, grid_x,grid_y)
	return res

n = num_paths(0, 0, 20, 20)
print "num paths in a 20x20 grid: ", n
