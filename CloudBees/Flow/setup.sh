#!/bin/bash

apt-get update
dpkg --add-architecture i386
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales
apt-get install -y lib32bz2-1.0 
apt-get install -y libuuid1:i386
apt-get install -y cifs-utils
apt-get install -y nfs-common

mkdir /net
mkdir /net/f2scratch/
mkdir /net/f2home/
mkdir /net/chronic3build/

mount f2:/vol/scratch /net/f2scratch/
mount f2:/vol/user/homes /net/f2home/
mount f2:/vol/chronic3build /net/chronic3build/
