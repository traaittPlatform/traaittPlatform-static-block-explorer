#!/bin/bash -e

# static explorer page generator
# by TurtleCoin Team, traaittPlatform 2020

# see LICENSE for details

HEIGHT=$(curl -s http://localhost:23896/getheight | jq '.height')
let "HEIGHT--"

cat ascii.txt

echo -e "\n### CURRENT BLOCK ###"
curl -s http://localhost:23896/getheight | jq -r 'to_entries|map("\(.key) - \(.value|tostring)")|.[]'

echo -e "\n### LAST BLOCK HEADER ###"
curl -sd '{"jsonrpc":"2.0","method":"getlastblockheader","params":{}}' http://localhost:23896/json_rpc | jq -r .result.block_header | jq -r 'to_entries|map("\(.key) - \(.value|tostring)")|.[]'

echo -e "\n### NETWORK INFO ###"
curl -s http://localhost:23896/getinfo | jq -r 'to_entries|map("\(.key) - \(.value|tostring)")|.[]' 

echo -e "\n### PENDING TRANSACTIONS ###"
curl -sd '{"jsonrpc":"2.0","method":"f_on_transactions_pool_json","params":{}}' http://localhost:23896/json_rpc | jq '.result.transactions[]' | jq -r 'to_entries|map("\(.key) - \(.value|tostring)")|.[]' 

echo -e "\n### LAST 10 BLOCKS ###"
curl -sd '{"jsonrpc":"2.0","method":"f_blocks_list_json","params":{"height":'"$HEIGHT"'}}' http://localhost:23896/json_rpc | jq '.result.blocks' | jq '.[0:10]'

cat footer.txt
