#!/bin/bash

# Task 1.C
# VARIABLE DESCRIPTION
## R : Roman numeral
## C : "Checkpoint", hardcoded values where the "pattern" for roman numerals changes
## n : Local variable for N
## D2R : Function that finds the number of occurances (F) of a checkpoint in a given number and prints it F times , for example, D2R(34,10,X) gives the answer as XXX as F = 3
## F : No. of occurances of a checkpoint in N
## K and V : (Key and Value) Decimal to Roman mapping for the checkpoints

N=$1

D2R()
{
    n=$1
    C=$2
    R=$3
    F=$((n/C))
    n=$((n-C*F))
    while [ $F -gt 0 ]
    do
        echo -n $R
        ((F--))
    done
    return $n
}

K=(100 90 50 40 10 9 5 4 1)
V=(C XC L XL X IX V IV I)

for i in {0..8}
do
    D2R $N ${K[$i]} ${V[$i]}
    N=$?
done
