#!/bin/bash

date=$(date +%Y.%m.%d -d "-90 days")
master=$(curl -s -XGET $HOSTNAME:9200/_cat/master?pretty |cut -d " " -f4)
validate=$(curl -s -XGET http://$HOSTNAME:9200/_cat/indices?pretty |grep logstash-$date |awk '{print$3}')
url=$(curl -s -XDELETE http://$HOSTNAME:9200/logstash-$date?pretty -H 'Content-Type:application/json')

if [ "$validate" != "logstash-$date" ]; then
echo "index does not exist"
elif [ "$master" != "$HOSTNAME" ]; then
echo "it's not the master"
else
echo $url
fi
