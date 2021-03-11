#!/bin/sh

# install docker & compose
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg -y
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo wget https://raw.githubusercontent.com/doristeo/SwarmMonitoring/main/docker/docker-compose.yaml
sudo mkdir /root/swarmon/ && sudo mkdir /root/swarmon/mysql && sudo mkdir /root/swarmon/mysql/init
sudo wget https://raw.githubusercontent.com/doristeo/SwarmMonitoring/main/docker/mysql/createdb.sql -P /root/swarmon/mysql/init
sudo mkdir /root/swarmon/grafana
sudo wget https://github.com/doristeo/SwarmMonitoring/raw/main/docker/grafana/grafana.tar.gz
sudo tar -zxvf grafana.tar.gz -C /root/swarmon/grafana
sudo docker-compose up -d
