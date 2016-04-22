#!/usr/bin/env python   

# ---------------------------------------------------------------
#This mapper code will input a line of text and output <word, 1>
# 
# ---------------------------------------------------------------

import sys

for line in sys.stdin:
	line = line.strip()
	keys = line.split()
	for key in keys:
		value = 1
		# The Hadoop default is "tab" separates key from the value
		print('{0}\t{1}'.format(key, value))

