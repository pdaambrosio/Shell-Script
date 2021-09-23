#!/bin/bash

OLDER=$(curl -s -XGET $HOSTNAME:9200/_cat/snapshots/backup?pretty |awk '{print $1}' |head -1)
DEL=$(curl -s -XDELETE $HOSTNAME:9200/_snapshot/backup/$OLDER)
SPACE=$(df -h |grep '/var' |awk '{print $5/100*100}')
CHECK=80
MASTER=$(curl -XGET $HOSTNAME:9200/_cat/master?pretty |cut -d " " -f4)

printf "Space ---- $SPACE\nCheck ---- $CHECK\nDEL ---- $DEL\n"

while [ "$SPACE" -gt "$CHECK" and "$MASTER" -eq "$HOSTNAME" ]
do
 echo "Removed"
 sleep 10
if [ "$SPACE" -lt "$CHECK" ]; then
 break
fi
done

echo "ok"