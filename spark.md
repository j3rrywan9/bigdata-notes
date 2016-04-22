# Spark

## Basics
Spark's primary abstraction is a distributed collection of items called a Resilient Distributed Dataset (RDD). RDDs can be created from Hadoop InputFormats (such as HDFS files) or by tranforming other RDDs.

RDDs have actions, which return values, and tranformations, which return pointers to new RDDs.

## Tranformations

### map(func)

### filter(func)

### flatMap(func)

### groupByKey

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

#### Load DataFrame from CSV
```
PYSPARK_DRIVER_PYTHON=ipython pyspark --packages com.databricks:spark-csv_2.10:1.3.0
```

Log analytics
```
sc._jsc.hadoopConfiguration().set('textinputformat.record.delimiter', '\r\n')
```
Read logs CSV
```python
logs_df = sqlCtx.load(source = 'com.databricks.spark.csv', header = 'true', inferSchema = 'true', path = 'file:///usr/lib/hue/apps/search/examples/collections/solr_configs_log_analytics_demo/index_data.csv')

logs_df.count()

logs_df.printSchema()

from pyspark.sql.functions import desc

logs_df.groupBy("code").count().orderBy(desc("count")).show()
```

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

## Spark and Hive Assignment
Q1: How many orders are in SUSPECTED_FRAUD status?
```python
sqlCtx.sql("SELECT COUNT(*) FROM orders WHERE order_status == 'SUSPECTED_FRAUD'").show()
```
Q2: Load the table "order_items" from Hive, find the total amount (sum of all "order_item_subtotal") for each order ("order_item_order_id"). What is the 3rd highest order amount?
```python
sqlCtx.sql("select sum(order_item_subtotal) as order_total from order_items group by order_item_order_id order by order_total desc limit 3").show()
```
Q3: What is the average product price ("order_item_product_price") from products that belong to "COMPLETE" orders?
```python
order_items = sqlCtx.sql("select * from order_items")

orders = sqlCtx.sql("select * from orders")

order_items = sqlCtx.createDataFrame(order_items.rdd, order_items.schema)

orders = sqlCtx.createDataFrame(orders.rdd, orders.schema)

oi_join_o = sqlCtx.sql("select * from order_items oi inner join orders o on oi.order_item_order_id = o.order_id")

oi_join_o.printSchema()

oi_join_o.cache()

oi_join_o.registerTempTable("oi_join_o_tbl")

sqlCtx.sql("select avg(order_item_product_price) from oi_join_o_tbl where order_status = 'COMPLETE'").show()
```
Q4: What is the maximum amount a single customer ordered?
```python
sqlCtx.sql("select sum(order_item_subtotal) as order_total from oi_join_o_tbl where order_status = 'COMPLETE' group by order_customer_id order by order_total desc limit 1").show()
```
Q5: Now let's focus on orders which are not complete. Find the total amount of each of those orders i.e. sum all the "order_item_subtotal" for each "order_id". What is the largest across all total amounts?
```python
sqlCtx.sql("select sum(order_item_subtotal) as order_total from oi_join_o_tbl where order_status <> 'COMPLETE' group by order_id order by order_total desc limit 1").show()
```

## Simple Join in Spark Assignment
Load dataset "join1_FileA.txt":
```python
fileA = sc.textFile("input/join1_FileA.txt")
```
Let's make sure the file content is correct:
```python
fileA.collect()
```
Then load the second dataset:
```python
fileB = sc.textFile("input/join1_FileB.txt")
```
Same verification:
```python
fileB.collect()
```
Mapper for fileA

[split_fileA](https://github.com/j3rrywan9/bigdata-notes/blob/master/simple_join_fileA_mapper.py)

Mapper for fileB

[split_fileB](https://github.com/j3rrywan9/bigdata-notes/blob/master/simple_join_fileB_mapper.py)

```python
fileA_data = fileA.map(split_fileA)

fileA_data.collect()

fileB_data = fileB.map(split_fileB)

fileB_data.collect()

fileB_joined_fileA = fileB_data.join(fileA_data)

fileB_joined_fileA.collect()
```

## Advanced Join in Spark Assignment

### Read show views files
**join2_gennum** files contain show names and number of viewers, you can read into Spark all of them with a pattern matching, see the **?** which will match either A, B or C:
```python
PYSPARK_DRIVER_PYTHON=ipython pyspark

show_views_file = sc.textFile("input/join2_gennum?.txt")
```
Remember you can check what Spark in doing by copying some elements of an RDD back to the driver:
```python
show_views_file.take(2)
```
will return the first 2 elements of the dataset.

### Parse show views files
Next you need to write a function that splits and parses each line of the dataset.
```python
def split_show_views(line):
	show, views_in = line.split(",")[0], line.split(",")[1]
	views = int(views_in)
	return (show, views)

show_views = show_views_file.map(split_show_views)
```

### Read channel files
**join2_genchan** files contain show names and channels.
```python
show_channel_file = sc.textFile("input/join2_genchan?.txt")
```

### Parse channel files
Now you need to write a function that splits and parses each line of the dataset.
```python
def split_show_channel(line):
	show, channel = line.split(",")[0], line.split(",")[1]
	return (show, channel)

show_channel = show_channel_file.map(split_show_channel)
```

### Join the 2 datasets
Join the 2 datasets using the show name as the key:
```python
joined_dataset = show_views.join(show_channel)
```

### Extract channel as key
You want to find the total viewers by channel, so you need to create an RDD with the channel as key and viewer counts as value, whichever is the show.
```python
def extract_channel_views(show_views_channel):
	channel_views = show_views_channel[1]
	channel, views = channel_views[1], channel_views[0]
	return (channel, views)
```
Now you can apply this function to the joined dataset to create an RDD of channel and views:
```python
channel_views = joined_dataset.map(extract_channel_views)
```

### Sum across all channels
```python
def sumFunc(accum, n):
	return accum + n 
```

```python
channel_views.reduceByKey(sumFunc).collect()
```

The output looks like below:
```
[(u'XYZ', 5208016),
 (u'DEF', 8032799),
 (u'CNO', 3941177),
 (u'BAT', 5099141),
 (u'NOX', 2583583),
 (u'CAB', 3940862),
 (u'BOB', 2591062),
 (u'ABC', 1115974),
 (u'MAN', 6566187)]
```
