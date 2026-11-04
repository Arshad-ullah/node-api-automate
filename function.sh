#!/bin/bash



# pass arguments
function test() {
    sume=$(($1+$2))
    echo "sum...$sume"

    return 32
}



test 23 32


echo $?