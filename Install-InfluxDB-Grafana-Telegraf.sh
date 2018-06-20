#/bin/bash
echo "InfluxDB installation"
wget --no-check-certificate https://s3.amazonaws.com/influxdb/influxdb_0.10.0-1_amd64.deb
dpkg -i influxdb_0.10.0-1_amd64.deb
service influxdb start
echo "Grafana installation"
wget --no-check-certificate https://grafanarel.s3.amazonaws.com/builds/grafana_2.6.0_amd64.deb
apt-get update
apt-get install -y adduser libfontconfig
dpkg -i grafana_2.6.0_amd64.deb
service grafana-server start
echo "Telegraf installation"
wget http://get.influxdb.org/telegraf/telegraf_0.10.2-1_amd64.deb
dpkg -i telegraf_0.10.2-1_amd64.deb
telegraf -sample-config > telegraf.conf 
telegraf -sample-config -input-filter cpu:mem:swap -output-filter influxdb > telegraf.conf
telegraf -config telegraf.conf
