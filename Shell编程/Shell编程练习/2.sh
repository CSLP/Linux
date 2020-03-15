#!/bin/bash
lp_name=2
lp_focus="nmsl"
echo $lp_name $lp_focus
echo ${lp_name} ${lp_focus}
#echo "I am good at $lp_name nmsl"
lp_name=3
unset lp_focus
echo $lp_focus
echo $lp_name
readonly lp_name
unset lp_name
echo $lp_name


