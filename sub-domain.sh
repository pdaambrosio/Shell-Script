#!/bin/bash

# ./sub-domain.sh domain.com
for url in $(cat sub-domain-lst.txt);
do host $url.$1 |grep "has address";
done
