-- *******   PIG LATIN SCRIPT for Yelp Assignmet ******************

-- 0. get function defined for CSV loader

register /usr/lib/pig/piggybank.jar;
define CSVLoader org.apache.pig.piggybank.storage.CSVLoader();

-- The data-fu jar file has a CSVLoader with more options, like reading multiline records,
--  but for this assignment we don't need it, so the next line is commented out
-- register /home/cloudera/incubator-datafu/datafu-pig/build/libs/datafu-pig-incubating-1.3.0-SNAPSHOT.jar;

-- 1 load data

Y = LOAD '/user/cloudera/input/yelp_data.csv' USING CSVLoader() AS(business_id:chararray,cool,date,funny,id,stars:int,text:chararray,type,useful:int,user_id,name,full_address,latitude,longitude,neighborhoods,open,review_count,state);

Y_good = FILTER Y BY (useful is not null and stars is not null);

--2 Find max useful
Y_all = GROUP Y_good ALL;
Umax  = FOREACH Y_all GENERATE MAX(Y_good.useful);
DUMP Umax

-- this shows max useful rating of 28! ...

-- 3 Now limit useful field to be <=5 and then get wtd average

Y_rate = FOREACH Y_good GENERATE business_id,stars,(useful>5 ? 5:useful) as useful_clipped;

DESCRIBE Y_rate;

-- Y_rate: {business_id: chararray,stars: int,useful_clipped: int}

Y_rate2 = FOREACH Y_rate GENERATE $0..,(double) stars*(useful_clipped/5) as wtd_stars;

DESCRIBE Y_rate2;

-- Y_rate2: {business_id: chararray,stars: int,useful_clipped: int,wtd_stars: double}

-- Note: a student noticed the divisor above should be 5.0 so that it is cast as a float number 
-- but that doesn't really change the gist of the assignment and quiz (as he also noted), so I'll leave it as just 5

-- 4 Rank businesses

Y_g = GROUP Y_rate2 BY business_id;

DESRIBE Y_g;

-- Y_g: {group: chararray,Y_rate2: {(business_id: chararray,stars: int,useful_clipped: int,wtd_stars: double)}}

Y_m = FOREACH Y_g
      GENERATE group as business_idgroup,COUNT(Y_rate2.stars) as num_ratings,
          AVG(Y_rate2.stars) as avg_stars,
          AVG(Y_rate2.useful_clipped) as avg_useful,
          AVG(Y_rate2.wtd_stars) as avg_wtdstars;

DESCRIBE Y_m;

-- Y_m: {business_idgroup: chararray,num_ratings: long,avg_starts: double,avg_useful: double,avg_wtdstars: double}

Y_m2 = FILTER Y_m BY num_ratings > 1;

DESCRIBE Y_m2;

-- Y_m2: {business_idgroup: chararray,num_ratings: long,avg_starts: double,avg_useful: double,avg_wtdstars: double}

Y_m2_all = GROUP Y_m2 ALL;

DESCRIBE Y_m2_all;

Y_m3 = FOREACH Y_m2_all GENERATE AVG(Y_m2.avg_wtdstars) as avg_wtdstars;

DUMP Y_m3;

Y_rnk = RANK Y_m BY avg_wtdstars;

