# Sqoop

## Load data from MySQL into HDFS
```
sqoop import-all-tables \
-m 1 \
--connect jdbc:mysql://quickstart:3306/retail_db \
--username=retail_dba \
--password=cloudera \
--compression-codec=snappy \
--as-avrodatafile \
--warehouse-dir=/usr/hive/warehouse
```
