# Spark

## Basics
Spark's primary abstraction is a distributed collection of items called a Resilient Distributed Dataset (RDD). RDDs can be created from Hadoop InputFormats (such as HDFS files) or by tranforming other RDDs.

RDDs have actions, which return values, and tranformations, which return pointers to new RDDs.

## Tranformations

### map(func)

### filter(func)

### flatMap(func)

### reduceByKey(func, [numTasks])

## Actions

### collect()

### count()

### first()

## Shared Variables

### Broadcast variables

### Accumulators

## PySpark
```
sudo easy_install ipython==1.2.1
sudo easy_install numpy==1.4.1
```

### Launch PySpark in IPython
```
PYSPARK_DRIVER_PYTHON=ipython pyspark
```

## Spark SQL
Spark SQL is a Spark module for structured data processing. Unlike the basic Spark RDD API, the interfaces provided by Spark SQL provides Spark with more information about the structure of both the data and the computation being performed. Internally, Spark SQL uses this extra information to perform extra optimizations. There are several ways to interact with Spark SQL including SQL, the DataFrames API and the Datasets API.

### DataFrames
A DataFrame is a distributed collection of data organized into named columns. It is conceptually equivalent to a table in a relational database or a data frame in R/Python, but with richer optimizations under the hood. DataFrames can be constructed from a wide array of sources such as: structured data files, tables in Hive, external databases, or existing RDDs.

The DataFrames API is available in Scala, Java, Python, and R.
