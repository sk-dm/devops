#!/bin/bash

apt update && apt install -y apt-transport-https git wget ca-certificates gnupg-agent
wget -O - https://download.docker.com/linux/debian/gpg | apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/debian buster stable" > /etc/apt/sources.list.d/docker.list
apt update && apt install -y docker-ce docker-ce-cli containerd.io
git clone https://github.com/sk-dm/devops/ /opt/devops
cd /opt/devops/
git pull https://github.com/sk-dm/devops master
cd project01
crontab crontab.conf
