#!/bin/bash

sudo apt-get install ruby

wget http://puppetlabs.com/downloads/facter/facter-latest.tgz

gzip -d -c facter-latest.tgz | tar xf -
cd facter-*
sudo ruby install.rb

wget http://puppetlabs.com/downloads/puppet/puppet-latest.tgz
gzip -d -c puppet-latest.tgz | tar xf -
cd puppet-*
sudo ruby install.rb
