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
--warehouse-dir=/user/hive/warehouse
```

### Verification
When above command is complete, confirm that your Avro data files exist in HDFS.
```
hadoop fs -ls /user/hive/warehouse
```
Will show a folder for each of the tables.
```
hadoop fs -ls /user/hive/warehouse/categories
```
Will show the files that live inside of the "categories" folder.

Sqoop should also have created schema files for this data in your home directory.
```
ls -l *.avsc
```
