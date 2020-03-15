#!/bin/bash
echo "-- \$* 实例---"
for i in "$*";do
	echo $i
done
echo "-- \$@ shili---"
for i in "$@";do
	echo $i
done
