#!/bin/bash
i=1
#while [ $i -le 5 ]
while (( $i<=5 ))
do
    echo $i
#    let "i++"
    i=`expr $i + 1`
#    i=$[i+1]
done
