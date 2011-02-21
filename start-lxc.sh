#!/bin/bash

ADDRESS=192.168.0.129

rsync -zvua --delete --progress /etc/puppet/ root@$ADDRESS:/var/lib/lxc/pfun/rootfs/etc/puppet/
ssh root@$ADDRESS /etc/puppet/bootstrap.sh
