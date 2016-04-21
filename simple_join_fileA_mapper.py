def split_fileA(line):
	# split the input line in word and count on the comma
	word_in, count_in = line.split(",")[0], line.split(",")[1]
	# turn the count to an integer
	word, count = word_in, int(count_in)
	return (word, count)

