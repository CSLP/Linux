#!/bin/bash
a=10
b=10
c=4
var1=`expr $a + $b`
var2=`expr $a - $b`
var3=`expr $a \* $b`
var4=`expr $a / $b`
var5=`expr $a % $b`
echo $var1
echo $var2
echo $var3
echo $var4
echo $var5
if [ $a == $b ]
then
   echo "a==b"
fi
a=$c
if [ $a != $b ]
then
  echo "a!=b"
fi
