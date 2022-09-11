#!/bin/bash

# ./nmap.sh 192.168.8.0/24
nmap -sV $1 |grep for |cut -d" " -f5-6
