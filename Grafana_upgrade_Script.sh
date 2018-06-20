#!/bin/bash
# Define a timestamp function
timestamp() {
date +"%Y-%m-%d_%H-%M-%S"
}
timestamp
echo "Let's pull latest grafana/grafana"
docker pull grafana/grafana
echo "Stopping grafana Container"
docker stop grafana
echo "Backing up old grafana Container to grafana_$(timestamp)"
docker rename grafana grafana_$(timestamp)
echo "Creating and starting new grafana Server"
docker create \
--name=grafana \
-p 3000:3000 \
--volumes-from grafanastorage \
-e "GF_SECURITY_ADMIN_PASSWORD=mygrafana" \
grafana/grafana
docker start grafana
