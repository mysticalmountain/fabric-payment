#!/bin/bash



ORDERER_CA=/etc/hyperledger/fabric/crypto/ordererOrganizations/andongxu.link/orderers/orderer.andongxu.link/msp/tlscacerts/tlsca.andongxu.link-cert.pem
PEER0_BANK_CA=/etc/hyperledger/fabric/crypto/peerOrganizations/bank.andongxu.link/peers/peer0.bank.andongxu.link/tls/ca.crt
PEER1_BANK_CA=/etc/hyperledger/fabric/crypto/peerOrganizations/bank.andongxu.link/peers/peer1.bank.andongxu.link/tls/ca.crt
PEER0_MERCHANT_CA=/etc/hyperledger/fabric/crypto/peerOrganizations/merchant.andongxu.link/peers/peer0.merchant.andongxu.link/tls/ca.crt
PEER1_MERCHANT_CA=/etc/hyperledger/fabric/crypto/peerOrganizations/merchant.andongxu.link/peers/peer1.merchant.andongxu.link/tls/ca.crt

# PEER0_ORG2_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
# PEER0_ORG3_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org3.example.com/peers/peer0.org3.example.com/tls/ca.crt

# verify the result of the end-to-end test
verifyResult() {
  if [ $1 -ne 0 ]; then
    echo "!!!!!!!!!!!!!!! "$2" !!!!!!!!!!!!!!!!"
    echo "========= ERROR !!! FAILED to execute End-2-End Scenario ==========="
    echo
    exit 1
  fi
}
   
setOrdererGlobals() {
  CORE_PEER_LOCALMSPID="OrdererMSP"
  CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_BANK_CA
  CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/fabric/crypto/peerOrganizations/bank.andongxu.link/users/Admin@bank.andongxu.link/msp
}

setGlobals() {
  PEER=$1
  ORG=$2
  if [ "$ORG" == "bank" ]; then
    CORE_PEER_LOCALMSPID="BankOrgMSP"
    CORE_PEER_MSPCONFIGPATH="/etc/hyperledger/fabric/crypto/peerOrganizations/bank.andongxu.link/users/Admin@bank.andongxu.link/msp"
    if [ $PEER -eq 0 ]; then
    	CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_BANK_CA
    	CORE_PEER_ADDRESS=peer0.bank.andongxu.link:7051
    else
    	CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_BANK_CA
    	CORE_PEER_ADDRESS=peer1.bank.andongxu.link:7051
    fi
  elif [ "$ORG" == "merchant" ]; then
    CORE_PEER_LOCALMSPID="MerchantOrgMSP"
    CORE_PEER_MSPCONFIGPATH="/etc/hyperledger/fabric/crypto/peerOrganizations/merchant.andongxu.link/users/Admin@merchant.andongxu.link/msp"
    if [ $PEER -eq 0 ]; then
    	CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_MERCHANT_CA
    	CORE_PEER_ADDRESS=peer0.merchant.andongxu.link:7051
    else
    	CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_MERCHANT_CA
    	CORE_PEER_ADDRESS=peer1.merchant.andongxu.link:7051
    fi
  else
    echo "================== ERROR !!! ORG Unknown =================="
  fi

  if [ "$VERBOSE" == "true" ]; then
    env | grep CORE
  fi
}
