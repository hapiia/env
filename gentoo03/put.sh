#!/usr/bin/env bash
# wget -nc https://github.com/hapiia/env/raw/master/gentoo03/put.sh

GIT_URL=https://github.com/hapiia/env/raw/master/gentoo03

mkdir /opt/docker
mkdir /opt/docker/data
mkdir /opt/docker/data/git
mkdir /opt/ansible

wget -nc ${GIT_URL}/firewall.yml -O /opt/ansible/firewall.yml
wget -nc ${GIT_URL}/service.yml -O /opt/ansible/service.yml
wget -nc ${GIT_URL}/fstab.yml -O /opt/ansible/fstab.yml
wget -nc ${GIT_URL}/hostname.yml -O /opt/ansible/hostname.yml

wget -nc ${GIT_URL}/docker-compose.yml -O /opt/docker/docker-compose.yml

wget -nc ${GIT_URL}/00_git_hapii.conf -O /etc/apache2/vhosts.d/00_git_hapii.conf
