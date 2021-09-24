#!/bin/bash

DATE=$(date +%Y.%m.%d -d "-15 days")
MASTER=$(curl -s -XGET $HOSTNAME:9200/_cat/master?pretty |cut -d " " -f4)
VALIDATE=$(curl -s -XGET $HOSTNAME:9200/_cat/indices?pretty |grep logstash-$DATE |awk '{print$3}')
SNAPSHOT=$(curl -s -XGET $HOSTNAME:9200/_cat/snapshots/backup?pretty |egrep "SUCCESS" |cut -d " " -f 1 |sort |tail -n2 |head -n1)

printf "DATA --- $DATE\n MASTER ---- $MASTER\n VALIDAR ---- $VALIDATE\n CURL ----- $CURL\n SNAPSHOT ---- $SNAPSHOT\n\n"

if [ "$VALIDATE" == "logstash-$DATE" ]; then
echo "index already exists"
elif [ "$MASTER" != "$HOSTNAME" ]; then
echo "it's not the master"
else
curl -XPOST $HOSTNAME:9200/_snapshot/backup/$SNAPSHOT/_restore?pretty -d '{"indices":"logstash-'$DATE'"}'
fi
