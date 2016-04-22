# MapReduce

## Join Data Assignment

### Part 1
Make scripts executable:
```
chmod +x join1_mapper.py
chmod +x join1_reducer.py
```
Test the program in serial execution using the following Unix utilities and piping commands:
```
cat join1_File*.txt | ./join1_mapper.py | sort | ./join1_reducer.py
```
Set up data in HDFS:
```
hdfs dfs -mkdir /user/cloudera/input
hdfs dfs -put /home/cloudera/join1_FileA.txt /user/cloudera/input
hdfs dfs -put /home/cloudera/join1_FileB.txt /user/cloudera/input
```
Run the Hadoop streaming command:
```
hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
 -input /user/cloudera/input \
 -output /user/cloudera/output_join \
 -mapper /home/cloudera/join1_mapper.py \
 -reducer /home/cloudera/join1_reducer.py
```

### Part 2
First generate some datasets using the script:
```
sh make_data_join2.txt
```
Set up data in HDFS:
```
hdfs dfs -mkdir /user/cloudera/input_join2
hdfs dfs -put /home/cloudera/join2_gen*.txt /user/cloudera/input_join2
```
Run the Hadoop streaming command:
```
hadoop jar /usr/lib/hadoop-mapreduce/hadoop-streaming.jar \
 -input /user/cloudera/input_join2 \
 -output /user/cloudera/output_join2 \
 -mapper /home/cloudera/join2_mapper.py \
 -reducer /home/cloudera/join2_reducer.py \
 -numReduceTasks 1
```
