#!/usr/bin/env python

## http://projecteuler.net/index.php?section=problems&id=19 ##
## How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)? ##

days_in_month = {
1:31,
2:0,
3:31,
4:30,
5:31,
6:30,
7:31,
8:31,
9:30,
10:31,
11:30,
12:31
}

def is_leap(year):
	if(year % 100 == 0):
		return year % 400 == 0
	else:
		return year % 4 == 0

def get_next_day(year, month, day):
	if(month == 12 and day == days_in_month[12]):
		return (year+1, 1, 1)
	days_in_month[2] = is_leap(year) and 29 or 28
	if(day == days_in_month[month]):
		return (year, month+1, 1)
	return (year, month, day + 1)

year = 1901
month = 1
day = 1
dotw = 1
num_sundays = 0

while year != 2001:
	if(day == 1 and dotw == 6):
		print year, "/", month, "/", day
		num_sundays += 1
	(year, month, day) = get_next_day(year, month, day)
	dotw += 1
	dotw = dotw % 7

print "number of sundays:", num_sundays
