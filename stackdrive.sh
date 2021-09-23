#!/bin/bash

REMOTE_COMMAND="curl -sSO https://dl.google.com/cloudagents/install-monitoring-agent.sh && \
    sudo bash install-monitoring-agent.sh && \
    sudo service stackdriver-agent restart"

for instance_name in $(gcloud --project "$MY_PROJECT" compute instances list --format="value(name)")
do
    zone=$(gcloud --project "$MY_PROJECT" compute instances list \
            --filter="name=($instance_name)" \
            --format="value(zone)")
    gcloud --project "$MY_PROJECT" compute ssh "$instance_name" \
        --zone="$zone" \
        --command "$REMOTE_COMMAND"
done