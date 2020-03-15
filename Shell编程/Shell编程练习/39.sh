#!/bin/bash
while read x
do
    case $x in
        1|2|3|4|5) echo "输入大于5的数字可跳出循环"
                    ;;
        *) echo "结束循环"
           break
           ;;
    esac
done