#!/bin/bash


peer=$1
org=$2

echo "peer=$peer"
echo "org=$org"

if [ "$peer" == "" -o "$org" == "" ]; then
    echo "!!!!!!!!!!!!!!! peer=$peer,org=$org !!!!!!!!!!!!!!!!"
    echo "========= ERROR !!! the peer and org is required ==========="
    echo
    exit 1
fi

. scripts/utils.sh
setGlobals $peer $org

echo "CORE_PEER_LOCALMSPID=$CORE_PEER_LOCALMSPID"
echo "CORE_PEER_TLS_ROOTCERT_FILE=$CORE_PEER_TLS_ROOTCERT_FILE"
echo "CORE_PEER_MSPCONFIGPATH=$CORE_PEER_MSPCONFIGPATH"
echo "CORE_PEER_ADDRESS=$CORE_PEER_ADDRESS"

CC_SRC_PATH="com/an/fabric/payment"
CC_RUNTIME_LANGUAGE=golang

echo "CC_SRC_PATH=$CC_SRC_PATH"
echo "CC_RUNTIME_LANGUAGE=$CC_RUNTIME_LANGUAGE"

peer chaincode install -n test -v 1.9 -p "$CC_SRC_PATH/test" -l "$CC_RUNTIME_LANGUAGE"


# Create the channel
# echo "===============================$1 install chaincode begin"

# CORE_PEER_LOCALMSPID="BankOrgMSP"
# CORE_PEER_MSPCONFIGPATH="/etc/hyperledger/fabric/crypto/peerOrganizations/bank.andongxu.link/users/Admin@bank.andongxu.link/msp"
# CORE_PEER_TLS_ROOTCERT_FILE="/etc/hyperledger/fabric/crypto/peerOrganizations/bank.andongxu.link/peers/peer0.bank.andongxu.link/tls/ca.crt"
# CORE_PEER_ADDRESS=peer0.bank.andongxu.link:7051
# PEER="peer0.bank.andongxu.link"
# CC_SRC_PATH="com/an/fabric/payment"
# CC_RUNTIME_LANGUAGE=golang

# if [ "$1" = "" ]; then
#     PEER="peer0.bank.andongxu.link"
# else
#     PEER=$1
# fi

# if [ "$PEER" == "peer0.bank.andongxu.link" ]; then
#     CORE_PEER_TLS_ROOTCERT_FILE="/etc/hyperledger/fabric/crypto/peerOrganizations/bank.andongxu.link/peers/peer0.bank.andongxu.link/tls/ca.crt"
#     CORE_PEER_MSPCONFIGPATH="/etc/hyperledger/fabric/crypto/peerOrganizations/bank.andongxu.link/users/Admin@bank.andongxu.link/msp"
#     CORE_PEER_ADDRESS=peer0.bank.andongxu.link:7051
#     CORE_PEER_LOCALMSPID="BankOrgMSP"
# elif [ "$PEER" == "peer1.bank.andongxu.link" ]; then
#     CORE_PEER_TLS_ROOTCERT_FILE="/etc/hyperledger/fabric/crypto/peerOrganizations/bank.andongxu.link/peers/peer1.bank.andongxu.link/tls/ca.crt"
#     CORE_PEER_MSPCONFIGPATH="/etc/hyperledger/fabric/crypto/peerOrganizations/bank.andongxu.link/users/Admin@bank.andongxu.link/msp"
#     CORE_PEER_ADDRESS=peer1.bank.andongxu.link:7051
#     CORE_PEER_LOCALMSPID="BankOrgMSP"
# elif [ "$PEER" == "peer0.merchant.andongxu.link" ]; then
#     CORE_PEER_TLS_ROOTCERT_FILE="/etc/hyperledger/fabric/crypto/peerOrganizations/merchant.andongxu.link/peers/peer0.merchant.andongxu.link/tls/ca.crt"
#     CORE_PEER_MSPCONFIGPATH="/etc/hyperledger/fabric/crypto/peerOrganizations/merchant.andongxu.link/users/Admin@merchant.andongxu.link/msp"
#     CORE_PEER_ADDRESS=peer0.merchant.andongxu.link:7051
#     CORE_PEER_LOCALMSPID="MerchantOrgMSP"
# elif [ "$PEER" == "peer1.merchant.andongxu.link" ]; then
#     CORE_PEER_TLS_ROOTCERT_FILE="/etc/hyperledger/fabric/crypto/peerOrganizations/merchant.andongxu.link/peers/peer1.merchant.andongxu.link/tls/ca.crt"
#     CORE_PEER_MSPCONFIGPATH="/etc/hyperledger/fabric/crypto/peerOrganizations/merchant.andongxu.link/users/Admin@merchant.andongxu.link/msp"
#     CORE_PEER_ADDRESS=peer1.merchant.andongxu.link:7051
#     CORE_PEER_LOCALMSPID="MerchantOrgMSP"
# fi



# echo "CORE_PEER_LOCALMSPID=$CORE_PEER_LOCALMSPID"
# echo "CORE_PEER_MSPCONFIGPATH=$CORE_PEER_MSPCONFIGPATH"
# echo "PEER=$PEER"

# docker exec \
#     -e "CORE_PEER_MSPCONFIGPATH=$CORE_PEER_MSPCONFIGPATH" \
#     -e "CORE_PEER_LOCALMSPID=$CORE_PEER_LOCALMSPID" \
#     -e "CORE_PEER_TLS_ROOTCERT_FILE=$CORE_PEER_TLS_ROOTCERT_FILE" \
#     -e "CORE_PEER_ADDRESS=$CORE_PEER_ADDRESS" \
#     cli peer chaincode install -n test -v 1.0 -p "$CC_SRC_PATH/test" -l "$CC_RUNTIME_LANGUAGE"

echo "install chaincode end"


