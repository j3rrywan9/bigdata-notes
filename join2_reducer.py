#!/usr/bin/env python
import sys

prev_tv_show = None
running_total = 0
abc_found = False

for line in sys.stdin:
	line = line.strip()       #strip out carriage return
	key_value = line.split('\t')   #split line, into key and value, returns a list
	curr_tv_show, value_in = key_value[0], key_value[1]
	
	if curr_tv_show != prev_tv_show:
		if abc_found:
			print('{0} {1}'.format(prev_tv_show, running_total))
			abc_fount = False
			running_total = 0
		if value_in != 'ABC':
			running_total = int(value_in)
	else: # curr_tv_show == prev_tv_show
		if value_in != 'ABC':
			running_total += int(value_in)
	if value_in == 'ABC':
		abc_found = True
	prev_tv_show = curr_tv_show

