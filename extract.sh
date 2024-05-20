#!/bin/bash
# log file (machine readable)

log1=source-data.csv

# log file (human readable)
log2=target-output.csv
echo 0>$log2

# data extraction
awk                                         \
  -F ";"                                    \
  '{                                        \
  offset = -4; \
  system("t=$(date -u -d " $4 " +%s);offset_t=`expr 3600 \* "offset"`;t_out=`expr $t + $offset_t`;echo -n `date -u -d @$t_out +%F,%H:%M`");       \
  down = int ($7 / 1000000) ;               \
  up = int ($8 / 1000000) ;                 \
  ping = int ($6) ;                         \
  print "," down "," up "," ping            \
  }'                                        \
  $log1 >> $log2

# # separate time and date fields
# sed -i '1!s/T/,/' $log2
