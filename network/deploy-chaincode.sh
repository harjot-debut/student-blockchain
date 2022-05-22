# # inside test-network
export PATH=${PWD}/../bin:$PATH

echo "PATH ==" $PATH

export FABRIC_CFG_PATH=$PWD/../config/

echo "FABRIC_CFG_PATH ==" $FABRIC_CFG_PATH

peer version

echo "packaging chaincode"
peer lifecycle chaincode package basic.tar.gz --path ../chaincode/student-record-system/ --lang golang --label basic_1.0

sleep 3

# echo "org1 turn"

echo "################################################"
echo "INSTALL CHAINCODE ON ORG1"
echo "################################################"

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=localhost:7051

peer lifecycle chaincode install basic.tar.gz

echo "PATH ==" $PATH

# export FABRIC_CFG_PATH=$PWD/../config/

echo "FABRIC_CFG_PATH ==" $FABRIC_CFG_PATH


sleep 20

# echo "org2 turn"

echo "################################################"
echo "INSTALL CHAINCODE ORG2"
echo "################################################"

export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=localhost:9051

peer lifecycle chaincode install basic.tar.gz



echo "peer lifecycle chaincode queryinstalled"

echo "org1 turn"

echo "################################################"
echo "QUERY INSTALLED CHAINCODE ON ORG1"
echo "################################################"



export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=localhost:7051

peer lifecycle chaincode queryinstalled

sleep 5

echo "org2 turn"


echo "################################################"
echo "QUERY INSTALLED CHAINCODE ON ORG2"
echo "################################################"

export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=localhost:9051

peer lifecycle chaincode queryinstalled


# sleep 5

# export PATH=${PWD}/../bin:$PATH

# export FABRIC_CFG_PATH=$PWD/../config/

# # echo "using package id "

export CC_PACKAGE_ID=basic_1.0:2d60f719eb0d713994b50e19968bfd9d94ca7ff723d2073c54d55cdef3490f1a



echo "################################################"
echo "APPROVE CHAINCODE ON ORG2"
echo "################################################"

export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
export CORE_PEER_ADDRESS=localhost:9051

sleep 5

peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID mychannel --name basic --version 1.0 --package-id $CC_PACKAGE_ID --sequence 1 --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"


sleep 6

echo "################################################"
echo "AAPROVE CHAINCODE ON ORG1"
echo "################################################"

export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_ADDRESS=localhost:7051

peer lifecycle chaincode approveformyorg -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID mychannel --name basic --version 1.0 --package-id $CC_PACKAGE_ID --sequence 1 --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"

sleep 4 

echo "################################################"
echo "CHECK CHAINCODE COMMIT READINESS"
echo "################################################"

peer lifecycle chaincode checkcommitreadiness --channelID mychannel --name basic --version 1.0 --sequence 1 --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" --output json

##############commiting chaincode 

sleep 5

echo "################################################"
echo "COMMITING CHAINCODE "
echo "################################################"


peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --channelID mychannel --name basic --version 1.0 --sequence 1 --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt"

sleep 3

echo "################################################"
echo "Query committed chaincode"
echo "################################################"
peer lifecycle chaincode querycommitted --channelID mychannel --name basic --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"


# sleep 10

# echo "################################################"
# echo "Using couchdb"
# echo "################################################"
# ./network.sh up -s couchdb


# sleep 20

# echo "################################################"
# echo "INVOKING AND QUERYING CHAINCODE"
# echo "################################################"



# ./chaincode-query.sh