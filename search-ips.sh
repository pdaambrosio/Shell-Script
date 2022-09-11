#!/bin/bash

echo "insert the RANGE:"

read RANGE

nmap -sP $RANGE |grep for |cut -d " " -f5-6

echo "...well done.."
