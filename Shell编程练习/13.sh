#!/bin/bash
var=(1 2 3 4 5 6)
var[10]=10
echo ${var[@]}
echo ${var[8]}
echo ${var[*]}
echo ${#var[*]}
echo ${#var[1]}
