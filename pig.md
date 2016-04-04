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

Syntax
```
LOAD 'data' [USING function] [AS schema]
```

'data' The name of the file or directory, in single quotes.

USING Keyword.

If the USING clause is omitted, the default load function PigStorage is used.

function The load function.
- You can use a built in function.
- You can write your own load function if your data is in a format that cannot be processed by the built in functions.

AS Keyword.

schema A schema using the AS keyword, enclosed in parentheses.

The loader produces the data of the type specified by the schema. If the data does not conform to the schema, depending on the loader, either a null value or an error is generated.

Usage

Use the LOAD operator to load data from the file system.

### FILTER
Selects tuples from a relation based on some condition.

Syntax
```
alias = FILTER alias BY expression;
```

alias

The name of the relation.

BY

Required keyword.

expression

A boolean expression.

Usage

Use the FILTER operator to work with tuples or rows of data (if you want to work with columns of data, use the FOREACH...GERNERATE operation).

FILTER is commonly used to select the data that you want; or, conversely, to filter out (remove) the data you don't want.

## Quiz
```
hdfs dfs -mkdir /user/cloudera/pigin
hdfs dfs -put /home/cloudera/testfile* /user/cloudera/pigin
```
