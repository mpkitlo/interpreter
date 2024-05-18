#!/bin/bash

ghc Main

echo "ZLE"
echo 
for file in "bad"/*; do
    ./Main < $file > res 
    echo "$res $file"
done
# echo "DOBRE"
# echo 
# for file in "good"/*; do
#     ./Main < $file
# done
