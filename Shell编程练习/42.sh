#!/bin/bash
add()
{
    read a
    read b
    return $[a+b]
}
add
echo $?