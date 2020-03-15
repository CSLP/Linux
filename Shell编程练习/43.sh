#!/bin/bash
func()
{
    echo $1
    echo $2
    echo $3
    echo $4
    echo $5
    echo $6
    echo $*
    echo $#
}
func 1 2 3 4 5 6