# Pig

##
A data flow indicates the order of operations for processing data.

```
pig -x local
```

```
pig -x mapreduce
```

## Pig Latin Basics

### LOAD
Loads data from the file system.

LOAD 'data' [USING function] [AS schema]

'data' The name of the file or directory, in single quotes.

USING Keyword.
If the USING clause is omitted, the default load function PigStorage is used.

function The load function.
- You can use a built in function.
- You can write your own load function if your data is in a format that cannot be processed by the built in functions.

## Quiz
```
hdfs dfs -mkdir /user/cloudera/pigin
hdfs dfs -put /home/cloudera/testfile* /user/cloudera/pigin
```
