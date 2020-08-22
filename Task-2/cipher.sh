#!/bin/bash

# Task 2

if [ $# -eq 0 ]
then
    echo "Usage: ./cipher.sh <url>"
    exit 1
fi

# Downloading the file from the given URL and storing it in 'encrypted.txt'
URL=$1
wget $URL -q -O encrypted.txt # -q hides the verbose present while running wget

LOWER='abcdefghijklmnopqrstuvwxyz'
SHIFT=1 # Specifies the Caeser shift
E_LASTLINE=$( cat encrypted.txt | tail -2 ) # Stores the Encrypted Last Line, which is assumed to contain (encrypted) 'Queen', 'Mary', or 'Majesty'

while [ $SHIFT -le 25 ] # Brute-force attack on the last line
do
	T_LOWER=''
	for i in {0..25}
	do
	    INDEX=$(( (i+SHIFT)%26 ))
	    T_LOWER+=${LOWER:INDEX:1}
	done
	UPPER=$( echo $LOWER | tr [:lower:] [:upper:] ) # Contains uppercase alphabets
	T_UPPER=$( echo $T_LOWER | tr [:lower:] [:upper:] ) # Contains uppercase translated alphabets

	ALPHABETS=$LOWER$UPPER # Entire english alphabet in both cases
	TRANSLATION=$T_LOWER$T_UPPER # The entire translation
	D_LASTLINE=$( echo $E_LASTLINE | tr $TRANSLATION $ALPHABETS ) # Decrypted Last Line
	TREASON=$( echo $D_LASTLINE | egrep -i 'queen|majesty' ) # Case-insensitive egrep search
	if [ ${#TREASON} -gt 0 ] # We have found the right translation
	then
		break
	else
		(( SHIFT++ ))
	fi
done

cat encrypted.txt | tr $TRANSLATION $ALPHABETS > deciphered.txt # Store the deciphered letter in 'deciphered.txt'

echo "PS. Give me the names." | tr $ALPHABETS $TRANSLATION >> encrypted.txt # Encrypt and append the line to encrypted.txt

exit 0
