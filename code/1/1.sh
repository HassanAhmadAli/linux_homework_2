#!/usr/bin/bash

# Check if the number of arguments is exactly 3
if [ "$#" -ne 3 ]; then
  echo "Error: Exactly 3 arguments are required, but you provided $#."
  echo "Usage: $0 arg1 arg2 arg3"
  exit 1
fi
# oldword=$1
# newword=$2
# suffix=$3
for file in `find . -type f -name "*.$3"`; do
    sed -i "s/$1/$2/g" $file
done