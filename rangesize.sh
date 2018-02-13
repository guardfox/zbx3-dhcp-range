#!/bin/bash 
if [ -z $1 ];
then
    echo "Range Argument required "
    echo "Usage: $0 ranges_start-range_end"
    echo "Example: $0 10.0.0.5-10.0.0.10"
    exit 1;
fi

rstart=`echo $1 | cut -d "-" -f1`
rend=`echo $1 | cut -d "-" -f2`

p()(printf %02x ${1//./ })
r=$[0x`p $rstart`-0x`p $rend`]
echo $[1+${r/-}]
