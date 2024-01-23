#!/bin/bash

if [ ! -f /root/eigenlayer/cli/operator/config/operator-config.yaml ]
then
 echo "eigenlayer operator setup not found, exiting..."
 exit 1
fi

cd ~
if [ -d avs-operator-setup ]; then rm -r avs-operator-setup; fi
git clone https://github.com/mangata-finance/avs-operator-setup.git
cd avs-operator-setup
chmod +x run.sh

read -p "ws rpc url? " ws
read -p "wallet password? " pwd

http=$(cat /root/eigenlayer/cli/operator/config/operator-config.yaml | grep eth_rpc_url | awk '{print $2}' )
ecdsa=$(cat /root/eigenlayer/cli/operator/config/operator-config.yaml | grep private_key_store_path | awk -F "operator_keys/" '{print $NF}' )
bls=$(cat /root/eigenlayer/cli/operator/config/operator-config.yaml | grep bls_private_key_store_path | awk -F "operator_keys/" '{print $NF}' )

sed 's/ETH_RPC_URL=/ETH_RPC_URL=$http/' .env
sed 's/ETH_WS_URL=/ETH_WS_URL=$ws/' .env
sed 's/~/.eigenlayer/operator_keys/ecdsa.key.json/$ecdsa/' .env
sed 's/ecdsa.key.json/$ecsda/' .env
sed 's/bls.key.json/$bls/' .env
sed 's/ECDSA_KEY_PASSWORD=/ECDSA_KEY_PASSWORD=$pwd/' .env
sed 's/BLS_KEY_PASSWORD=/BLS_KEY_PASSWORD=$pwd/' .env

./run.sh opt-in
