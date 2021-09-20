#!/bin/bash

# ./reverse-dns.sh 192.168.8 (three octets)
for ip in $(seq 0 255);
do host $1.$ip |grep -v "not found";
done