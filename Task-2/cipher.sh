#!/bin/bash

if [ $# -eq 0 ]
then
    echo "Usage: ./cipher.sh <url>"
    exit 1
fi

URL=$1
wget $URL -q -O encrypted.txt # -q hides the verbose present

LOWER='abcdefghijklmnopqrstuvwxyz'

T_LOWER=''

SHIFT=18
for i in {0..25}
do
    INDEX=$(( (i+SHIFT)%26 ))
    T_LOWER+=${LOWER:INDEX:1}
done

UPPER=$( echo $LOWER | tr [:lower:] [:upper:] )
T_UPPER=$( echo $T_LOWER | tr [:lower:] [:upper:] )

ALPHABETS=$LOWER$UPPER
TRANSLATION=$T_LOWER$T_UPPER

echo $TRANSLATION

cat encrypted.txt | tr $ALPHABETS $TRANSLATION