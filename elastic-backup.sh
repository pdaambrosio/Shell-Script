#!/bin/bash

master=$(curl -XGET $HOSTNAME:9200/_cat/master?pretty |cut -d " " -f4)

if [ "$master" = "$HOSTNAME" ]; then
 sleep 3
 curator --config /etc/elasticsearch/curator-config.yml /etc/elasticsearch/curator-action.yml
else
 echo "it's not the master"
fi