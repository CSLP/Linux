#/bin/bash
str1="helloworld"
str2="helloworld"
str3="nimasil"
str4=""
if [ $str1 = $str2 ]
then
    echo "$str1=$str2"
fi
if [ $str1 != $str3 ]
then
    echo "$str1!=$str3"
fi
if [ -z $str4 ]
then    
   echo "$str4长度为0"
fi
if [ -n $str1 ]
then    
   echo "$str1长度不为0"
fi
if [ $str4 ]
then
   echo "字符串不为空"
else
   echo "字符串为空"
fi