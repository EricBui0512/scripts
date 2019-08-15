#!/bin/bash

### this file used to restart the blockchain protocol node and re run it again
## the log file (nohub.out) will be save on data/egt/coin/ - the same folder of this script
##
baseBieth=`pwd`
biPideth=`ps -ef | egrep -v "tail|grep|egrep" | grep "datadir" | grep "eth" |awk '{print $2}'`

baseBietc=`pwd`
biPidetc=`ps -ef | egrep -v "tail|grep|egrep" | grep "datadir" | grep "etc" | awk '{print $2}'`


localIp=`/sbin/ip a | grep "\binet\b" |awk '{print $2}'| egrep -e "^10|172|192" | awk -F"/" '{print $1; exit;}'`

checkDoIt(){
    if [ $? -ne 0 ]; then
        exit 11
    fi
}

killIt=`which kill`
killPids(){
    for pid in $1
    do
        if [ -n "$pid" -a "$pid" -gt 100 ]; then
            $killIt -9 $pid > /dev/null
            sleep 2
        fi
    done
}

### this one is used to check for Ethereum classic protocol and don't use in this case, but leave it here
checkEtcLive(){
	cd $baseBietc
    if [ -n "$biPidetc" ]; then
    	killPids $biPidetc 2> /dev/null
        checkDoIt
    	/usr/bin/nohup $baseBietc/geth --port 30403 --rpc --rpcport 8645 --rpcaddr=$localIp --datadir /data/coin/etc --max-peers 30 >> $baseEtc/nohup.out 2>&1 &
    elif [ -z "$biPidetc" ]; then
    	/usr/bin/nohup $baseBietc/geth --port 30403 --rpc --rpcport 8645 --rpcaddr=$localIp --datadir /data/coin/etc --max-peers 30 >> $baseEtc/nohup.out 2>&1 &
    fi
}

checkEthLive(){
	cd $baseBieth
    if [ -n "$biPideth" ]; then
    	killPids $biPideth 2> /dev/null
        checkDoIt
    	/usr/bin/nohup $baseBieth/geth --rpc --rpcport 8545 --rpcaddr=$localIp --datadir /data/coin/eth --maxpeers 30 >> $baseBieth/nohup.out 2>&1 &
    elif [ -z "$biPideth" ]; then
    	/usr/bin/nohup $baseBieth/geth --rpc --rpcport 8545 --rpcaddr=$localIp --datadir /data/coin/eth --maxpeers 30 >> $baseBieth/nohup.out 2>&1 &
    fi
}
#checkEtcLive
checkEthLive

