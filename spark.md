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
It is also possible to launch the PySpark shell in IPython, the enhanced Python interpreter. PySpark works with IPython 1.0.0 and later. To use IPython, set the **PYSPARK_DRIVER_PYTHON** variable to **ipython** when running **bin/pyspark**:
```
PYSPARK_DRIVER_PYTHON=ipython pyspark
```

## Spark SQL
Spark SQL is a Spark module for structured data processing. Unlike the basic Spark RDD API, the interfaces provided by Spark SQL provides Spark with more information about the structure of both the data and the computation being performed. Internally, Spark SQL uses this extra information to perform extra optimizations. There are several ways to interact with Spark SQL including SQL, the DataFrames API and the Datasets API.

### DataFrames
A DataFrame is a distributed collection of data organized into named columns. It is conceptually equivalent to a table in a relational database or a data frame in R/Python, but with richer optimizations under the hood. DataFrames can be constructed from a wide array of sources such as: structured data files, tables in Hive, external databases, or existing RDDs.

The DataFrames API is available in Scala, Java, Python, and R.

### SQLContext
The entry point into all functionality in Spark SQL is the SQLContext class, or one of its descendants.

### Creating DataFrames
With a SQLContext, applications can create DataFrames from an existing RDD, from a Hive table, or from data sources.

## DataFrame Analytics Assignment
```
PYSPARK_DRIVER_PYTHON=ipython pyspark --packages com.databricks:spark-csv_2.10:1.3.0
```

```python
yelp_df = sqlCtx.load(source = 'com.databricks.spark.csv', header = 'true', inferSchema = 'true', path = 'file:///usr/lib/hue/apps/search/examples/collections/solr_configs_yelp_demo/index_data.csv')

yelp_df.printSchema()

# The mean of the "cool" column across all of the dataset
yelp_df.agg({"cool": "mean"}).collect()

# Take into consideration only the records with a "review count" of 10 or more 
useful_yelp_df = yelp_df.filter(yelp_df["review_count"] >= 10)

# The average of the "cool" column for venues grouped by "stars"
useful_yelp_df.groupBy("stars").avg("cool").show()

# Take into consideration only the records with "open" state
useful_open_yelp_df = useful_yelp_df.filter(useful_yelp_df["open"] == True)

# The average of the "cool" column for venues grouped by "stars"
useful_open_yelp_df.groupBy("stars").avg("cool").show()
```
