#!/bin/bash

# Task 1.B

N_ARGS=$#

if [ $N_ARGS -eq 0 ]
then
    echo "No numbers given"
    exit 1
else
    SUM=0
    for (( i=1; i<=$N_ARGS; i++))
    do 
        SUM=$(./sum.sh $SUM ${!i})
    done
    echo $SUM
    exit 0
fi