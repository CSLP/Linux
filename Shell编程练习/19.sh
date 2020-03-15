#/bin/bash
a=10
b=20
if [ $a -eq $b ]
then
    echo "$a=$b"
fi	
if [ $a -ne $b ]
then
    echo "$a!=$b"
fi	
if [ $a -gt $b ]
then
    echo "$a>$b"
fi	
if [ $a -lt $b ]
then
    echo "$a<$b"
fi	
if [ $a -ge $b ]
then
    echo "$a>=$b"
fi	
if [ $a -le $b ]
then
    echo "$a<=$b"
fi	
