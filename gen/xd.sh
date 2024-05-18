#!/bin/bash

ghc Main

echo "bledy test"
echo 
for file in "bad"/*; do
    ./Main < "$file" 1> res 2> err 

    if [ -s err ]; then
        echo "$file: Dobrze"
        cat err
    else
        echo "$file: Zle"
        cat res
    fi
done

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
