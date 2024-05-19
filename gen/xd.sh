#!/bin/bash

ghc Main



echo "dobre testy"
echo 
for file in "good"/*; do
    ./Main < "$file" 1> res 2> err 

    if [ -s err ]; then
        echo "$file: Zle"
        cat err
    else
        echo "$file: Dobrze"
        cat res
    fi
done
