#!/bin/bash

# Task 1.A
## Assumption: The given 2 args are integers.

if [ $# -eq 2 ] # '$#' gives the number of command line args supplied
then
    SUM=$(( $1 + $2 ))
    echo $SUM
    exit 0
else
    echo 'Wrong number of arguments, expected 2'
    exit 1
fi
