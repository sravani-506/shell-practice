#!/bin/bash

num1=$1
num2=$2

Timestamp=$(date)
echo "Executed at: $Timestamp"

Sum=$(($num1+$num2))
echo "Sum of the $num1 and $num2 is $Sum"
