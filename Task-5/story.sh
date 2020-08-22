#!/bin/bash

# Task 5

DIR=$1 # Directory containing the snippets
KEY=$2 # Stores the initial key supplied as an arg
OUT=$3 # Path to the output file
> $OUT # Clears the contents of the output file first

while [ 1 ]
do
    # Find $KEY recursively in $DIR and using `-n` show the line number too.
    # (Note: Line numbers are shown as ":n:" where n is the line number)
    # Pipe this to another grep which looks for `:2:`, thus we get the file
    # Then, pipe this to `cut` which returns the first field delimited by ':'
    FILE=$( grep -rn "$KEY" $DIR | grep ":2:$KEY$" | cut -d ':' -f1 )
    if [ ${#FILE} -eq 0 ] # Break when $FILE becomes empty, i.e we there is no file with the given $KEY
    then
        break
    else
        LINE=$( head -1 $FILE ) # Gets the first line of the file
        KEY=$( tail -1 $FILE ) # Gets the 3rd line of the file, i.e the next key
        echo $LINE >> $OUT # '>>' appends to the given file
    fi
done

