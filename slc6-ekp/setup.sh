#!/bin/bash

## Add key
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

## Add repository

if[[ ! -e /etc/apt/sources.list.d/docker.list]]
then 
	echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
fi
## install docker engine and depend progs for cvmfs 
apt-get update
apt-get -y install docker-engine curl attr uuid-dev uuid

# install cvmfs
if[[ ! -d /root/tmp_install]]
then
	mkdir -p /root/tmp_install
fi
cd /root/tmp_install

if[[ ! -e cvmfs_2.1.20_amd64.deb]]
then
	wget https://ecsft.cern.ch/dist/cvmfs/cvmfs-2.1.20/cvmfs_2.1.20_amd64.deb
fi


if[[ ! -e cvmfs_2.1.20_amd64.deb]]
then
	wget https://ecsft.cern.ch/dist/cvmfs/cvmfs-config/cvmfs-config-default_latest_all.deb
fi

dpkg -i cvmfs-config-default_latest_all.deb cvmfs_2.1.20_amd64.deb

## create folder for cvmfs cache 
mkdir -p /local/scratch/cvmfs-cache/cms.cern.ch


## load config files for cvmfs 
cp /usr/users/mschnepf/docker/dockers/slc6-ekp/etc-cvmfs-domain-local /etc/cvmfs/domain.d/cern.ch.local
cp /usr/users/mschnepf/docker/dockers/slc6-ekp/etc-cvmfs-default-local /etc/cvmfs/default.local
cp  /usr/users/mschnepf/docker/dockers/slc6-ekp/etc-cvmfs-keys/* /etc/cvmfs/keys/

## remove this line if mount cvmfs with autofs
echo "cms.cern.ch /cvmfs/cms.cern.ch cvmfs defaults 0 0" >> /etc/fstab

## install sercurity files for HTCondor


## restart host 
echo "!!!!!!!!"
echo "it could be that autofs dosn't mount /usr/users/ after reboot"
echo "!!!!!!!!"

sleep 5
reboot








