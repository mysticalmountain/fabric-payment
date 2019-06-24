# MSP配置
+ 使用`cryptogen`工具 + `crypto-config.yaml`配置文件中的`OrderOrgs`和`PeerOrgs`生成`ca msp peers tlsca users`证书
```shell
../bin/cryptogen generate --config=./crypto-config.yaml
```
+ 使用`configtxgen`工具 + `configtx.yaml`配置文件生成channel artifacts
```shell
./scripts/generate-channel-artifacts.sh
```
+ 设置环境变量，因为`docker-compose-base.yaml`文件从环境变量中获取`IMAGE_TAG`
```shell
export IMAGE_TAG=1.4.0
```
# 启动docker容器
```shell
docker-compose -f docker-compse.yaml up
```
# 创建channel
+ 创建channel
```shell
./scripts/create-channel.sh
```
+ peer加入channel
```shell
./scripts/join-channel.sh
```
+ 查询channel配置信息
```shell
./scripts/get-channel-config.sh
```

# Chaincode配置
+ install chaincode
```shell
./scripts/install-chaincode.sh
```
+ instantiate chaincode
```shell
./scripts/instantiate-chaincode.sh
```

# 使用Client调用chaincode
```shell
./scripts/chaincode-create.sh
./scripts/chaincode-invoke.sh
./scripts/chaincode-query.sh
```

# 通过API调用chaincode
```shell
cd app
node enrollAdmin.js
node registerUser.js
node query.js
```


# Other
```shell
docker rm -f $(docker ps -aq)
docker rmi -f $(docker images | grep fabcar | awk '{print $3}')
```
