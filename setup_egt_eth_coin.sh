#!/bin/bash
#Name: setup egt eth coin
#Author:
#version: 0.1
#date: 2019-06-08

sudo su-
apt-get update
wget https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.8.15-89451f7c.tar.gz
tar zxf geth-linux-amd64-1.8.15-89451f7c.tar.gz
mkdir -p /data/egt/coin/eth
mkdir -p /data/coin/eth
cd /data/egt/coin/eth
mv /root/geth-linux-amd64-1.8.15-89451f7c/* ./
ls
cd /data/egt/coin/eth
nohup /data/egt/coin/eth/geth --rpc --rpcport=8545 --rpcaddr=127.0.0.1 --datadir=/data/coin/eth --maxpeers 100
ps -aux |grep geth
curl -H "Content-Type:application/json" -X POST --data '{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":67}' 127.0.0.1:8545