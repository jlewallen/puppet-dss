#!/bin/bash

apt-get update
apt-get -q -y install ruby rubygems libaugeas-ruby libaugeas-ruby1.8

mkdir -p /bootstrapping
pushd /bootstrapping

wget http://puppetlabs.com/downloads/facter/facter-latest.tgz
gzip -d -c facter-latest.tgz | tar xf -
pushd facter-*
ruby install.rb
popd

wget http://puppetlabs.com/downloads/puppet/puppet-latest.tgz
gzip -d -c puppet-latest.tgz | tar xf -
pushd puppet-*
ruby install.rb
popd

popd

pushd /etc/puppet
puppet -v manifests/site.pp
popd

