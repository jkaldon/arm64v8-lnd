#!/bin/sh

if [ -d /data/lnd ]; then
  echo 'Found existing directory at /data/lnd.  Skipping initialization.'

else
  mkdir -p /data/lnd
  echo "Created /data/lnd directory."
  
  sed -E "s/^bitcoind.rpcuser=.*$/bitcoind.rpcuser=${RPC_USERNAME}/" /home/lnd/lnd.conf.template > /data/lnd/lnd.conf
  sed -E -i "s/^bitcoind.rpcpass=.*$/bitcoind.rpcpass=${RPC_PASSWORD}/" /data/lnd/lnd.conf
  
  echo "Updated /data/lnd/lnd.conf with credentials for '${RPC_USERNAME}'."
fi

# Thanks to the following "safety" feature, it's not possible for LND
# to listen on 0.0.0.0 and use external SSL termination. 
# https://github.com/lightningnetwork/lnd/blob/master/lncfg/address.go#L74
#
# As a result of this artificial limitation, we edit the configuration file
# to listen on the ip address of the pod during initialization.
POD_IP=$(hostname -i)
sed -E -i "s/^restlisten=.+(:.+)$/restlisten=${POD_IP}\1/g" /data/lnd/lnd.conf
echo "Updated /data/lnd/lnd.conf to listen on address '${POD_IP}'."

echo 'Finished!'
