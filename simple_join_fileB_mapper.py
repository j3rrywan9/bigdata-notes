def split_fileB(line):
	# split the input line into word, date and count_string
	date, word, count_string = line.split(",")[0].split(" ")[0], line.split(",")[0].split(" ")[1], line.split(",")[1]
	return (word, date + " " + count_string)

