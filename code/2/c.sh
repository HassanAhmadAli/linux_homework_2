#!/bin/bash

for file in `find . -type f -name "*x"`; do
    if [ -f "$file" ]; then
        echo "\nHello Linux" >> "$file"
    fi 
done