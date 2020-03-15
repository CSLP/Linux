#!/bin/bash
num1=$[10+10]
num2=$[10+20]
if test $num1 -eq $num2
then 
    echo "$num1==$num2"
else 
    echo "$num1!=$num2" 
fi
if test %num1 == $num2
then 
    echo "$num1==$num2"
elif [ $num1 -gt $num2 ]
then
    echo "$num1>$num2"
elif [ $num1 -lt $num2 ]
then 
    echo "$num1<$num2"
else 
    echo "false"
fi
