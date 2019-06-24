#!/bin/bash

# Create the channel
echo "create channel begin"

CHANNEL_NAME=$1


if [ "$1" == "" ]; then
    echo "!!!!!!!!!!!!!!! "$1" !!!!!!!!!!!!!!!!"
    echo "========= ERROR !!! the channel name is required ==========="
    echo
    exit 1
fi

. scripts/utils.sh

setGlobals 0 bank

echo "CHANNEL_NAME=$CHANNEL_NAME"
echo "CORE_PEER_LOCALMSPID=$CORE_PEER_LOCALMSPID"
echo "CORE_PEER_TLS_ROOTCERT_FILE=$CORE_PEER_TLS_ROOTCERT_FILE"
echo "CORE_PEER_MSPCONFIGPATH=$CORE_PEER_MSPCONFIGPATH"
echo "CORE_PEER_ADDRESS=$CORE_PEER_ADDRESS"


peer channel create -o orderer.andongxu.link:7050 -c $CHANNEL_NAME -f /etc/hyperledger/fabric/configtx/channel.tx --tls --cafile $ORDERER_CA>&log.txt


# docker exec \
# 	-e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto/peerOrganizations/bank.andongxu.link/users/Admin@bank.andongxu.link/msp" \
# 	-e "CORE_PEER_ADDRESS=peer0.bank.andongxu.link" \
# 	-e "CORE_PEER_LOCALMSPID=BankOrgMSP" \
# 	-e "CORE_PEER_TLS_ROOTCERT_FILE=/etc/hyperledger/fabric/crypto/peerOrganizations/bank.andongxu.link/peers/peer0.bank.andongxu.link/tls/ca.crt" \
# 	cli \
# peer channel create \
# 	-o orderer.andongxu.link:7050 \
# 	-c mychannel \
# 	-f /etc/hyperledger/fabric/configtx/channel.tx \
# 	--tls --cafile /etc/hyperledger/fabric/crypto/ordererOrganizations/andongxu.link/orderers/orderer.andongxu.link/msp/tlscacerts/tlsca.andongxu.link-cert.pem


#	-e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bank.andongxu.link/users/Admin@bank.andongxu.link/msp" \
#	-e "CORE_PEER_ADDRESS=peer0.bank.andongxu.link:7051" \
#	-e "CORE_PEER_LOCALMSPID=BankOrgMSP" \
#	-e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bank.andongxu.link/peers/peer0.bank.andongxu.link/tls/ca.crt" \
#	peer1.bank.andongxu.link \
#	peer channel create \
#		-o orderer.andongxu.link:7050 \
#		-c mychannel \
#		-f ./channel-artifacts/channel.tx \
#		--tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/andongxu.link/orderers/orderer.andongxu.link/msp/tlscacerts/tlsca.andongxu.link-cert.pem#


echo "create channel end"
