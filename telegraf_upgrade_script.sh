#!/bin/bash
# Define a timestamp function
timestamp() {
date +"%Y-%m-%d_%H-%M-%S"
}
timestamp
echo "Pull Latest telegraf"
docker pull telegraf
echo "Stopping telegraf Container"
docker stop telegraf
echo "Backing up old telegraf Container to telegraf_$(timestamp)"
docker rename telegraf telegraf_$(timestamp)
echo "Creating and starting new telegraf Server"
docker run\
--name telegraf\
--restart=always\
--net=container:influxdb\
-v /monitoring/telegraf/telegraf.conf:/etc/telegraf/telegraf.conf:ro\
telegraf
