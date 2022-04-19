#!/bin/bash

    temp_file=`mktemp`
    cp $1 $temp_file
    period=`grep -aoe "<tint>.*</tint>" $temp_file`
    period=`echo $period | cut -d ">" -f2 | cut -d "<" -f1`

    time=`grep -aoe "<time>.*</time>" $temp_file`
    time=`echo $time | cut -d ">" -f2 | cut -d "<" -f1`

    echo "Processing $1"
    echo "Duration: "$time" Sampling Period: "$period

    killpoint=1
    while read line
    do
	      isEnd=`echo $line | grep -c "</dlog>"`
	      if [ $isEnd -gt 0 ]
	      then
	          break
	      fi
	      (( killpoint += 1 ))
    done < $temp_file

    cm="1,$killpoint""d"
#    echo $cm
    sed -i $cm $temp_file

    octave -q ./dlogToCsv.m $temp_file $period /app/output/"$(basename "$1" | sed 's/\(.*\)\..*/\1/')".csv
    rm $temp_file
