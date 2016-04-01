# HDFS

## Commands
All HDFS commands are invoked by the **bin/hdfs** script. Running the hdfs script without any arguments prints the description for all commands.

```
hdfs dfs -ls /
hdfs dfs -mkdir /user/test
hdfs dfs -put sample.txt /user/test
hdfs fsck /user/test/sample.txt
```

```
hdfs dfsadmin -report
```

## Java API

## WebHDFS REST API

### HDFS Configuration Options
dfs.webhdfs.enabled
dfs.web.authentication.kerberos.principal
dfs.web.authentication.kerberos.keytab
