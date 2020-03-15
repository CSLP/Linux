#!/bin/bash
var=lp
str1='my name is '$var''
str2='my name is $var'
echo $str1 $str2
str3="my name is $var"
str4="my name is "$var""
str5="my name is \$var"
echo $str3 $str4 $str5
