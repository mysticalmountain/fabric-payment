#!/bin/bash
export PATH=${PWD}/../bin:${PWD}:$PATH

export FABRIC_CFG_PATH=${PWD}
echo "FABRIC_CFG_PATH=$FABRIC_CFG_PATH"
which configtxgen
if [ "$?" -ne 0 ]; then
  echo "configtxgen tool not found. exiting"
  exit 1
fi


CHANNEL_NAME="mychannel"
CONSENSUS_TYPE='solo'
echo "##########################################################"
echo "#########  Generating Orderer Genesis block ##############"
echo "##########################################################"
# Note: For some unknown reason (at least for now) the block file can't be
# named orderer.genesis.block or the orderer will fail to launch!
echo "CONSENSUS_TYPE="$CONSENSUS_TYPE
set -x
if [ "$CONSENSUS_TYPE" == "solo" ]; then
  configtxgen -profile TwoOrgsOrdererGenesis -channelID byfn-sys-channel -outputBlock ./channel-artifacts/genesis.block
elif [ "$CONSENSUS_TYPE" == "kafka" ]; then
  configtxgen -profile SampleDevModeKafka -channelID byfn-sys-channel -outputBlock ./channel-artifacts/genesis.block
else
  set +x
  echo "unrecognized CONSESUS_TYPE='$CONSENSUS_TYPE'. exiting"
  exit 1
fi
res=$?
set +x
if [ $res -ne 0 ]; then
  echo "Failed to generate orderer genesis block.."
  exit 1
fi
echo
echo "#################################################################"
echo "### Generating channel configuration transaction 'channel.tx' ###"
echo "#################################################################"
set -x
configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME
res=$?
set +x
if [ $res -ne 0 ]; then
  echo "Failed to generate channel configuration transaction.."
  exit 1
fi

echo
echo "#################################################################"
echo "#######    Generating anchor peer update for BankOrgMSP   ##########"
echo "#################################################################"
set -x
configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/BankOrgMSPanchors.tx -channelID $CHANNEL_NAME -asOrg BankOrgMSP
res=$?
set +x
if [ $res -ne 0 ]; then
  echo "Failed to generate anchor peer update for BankOrgMSP.."
  exit 1
fi

echo
echo "#################################################################"
echo "#######    Generating anchor peer update for MerchantOrgMSP   ##########"
echo "#################################################################"
set -x
configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/MerchantOrgMSPanchors.tx -channelID $CHANNEL_NAME -asOrg MerchantOrgMSP
res=$?
set +x
if [ $res -ne 0 ]; then
  echo "Failed to generate anchor peer update for MerchantOrgMSP.."
  exit 1
fi
echo
