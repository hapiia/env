#!/usr/bin/env bash
# wget -nc https://github.com/hapiia/env/raw/master/gentoo03/put.sh

GIT_URL=https://github.com/hapiia/env/raw/master/gentoo03

mkdir /opt/docker
mkdir /opt/docker/data
mkdir /opt/docker/data/git
mkdir /opt/ansible

wget -nc ${GIT_URL}/firewall.yml -O /etc/ansible/firewall.yml
wget -nc ${GIT_URL}/service.yml -O /etc/ansible/service.yml
wget -nc ${GIT_URL}/fstab.yml -O /etc/ansible/fstab.yml
wget -nc ${GIT_URL}/hostname.yml -O /etc/ansible/hostname.yml

wget -nc ${GIT_URL}/docker-compose.yml -O /etc/docker/docker-compose.yml

wget -nc ${GIT_URL}/00_git_hapii.conf -O /etc/apache2/vhosts.d/00_git_hapii.conf
