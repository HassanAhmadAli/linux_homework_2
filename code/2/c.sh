#!/bin/bash

for file in *x; do
    if [ -f "$file" ]; then
        echo "\nHello Linux" >> "$file"
    fi
done