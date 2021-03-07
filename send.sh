#!/bin/bash

function makejson(){
  name=$HOSTNAME
  peers=$(curl -s http://localhost:1635/peers | jq '.peers | length')
  diskavail=$(df -P . | awk 'NR==2{print $2}')
  diskfree=$(df -P . | awk 'NR==2{print $4}')
  json='{"name":"'"$name"'","peers":'$peers',"diskavail":'$diskavail',"diskfree":'$diskfree',"cheque":'$cheque'}'
}

if [ $# -eq 0 ]
  then
    echo "I need URL of your Rest API!"
    exit 1
fi
makejson
curl -i \
-H "Accept: application/json" \
-H "Content-Type:application/json" \
-X POST --data ""$json"" ""$1""
