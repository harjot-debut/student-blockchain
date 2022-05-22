
./network.sh up -s couchdb



echo "###########################################"
echo "1). INVOKE AddStudent function of chaincode "
echo "###########################################"

sleep 3

echo "###########################################"
echo "ADDING FIRST STUDENT"
echo "###########################################"

sleep 3

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C mychannel -n basic --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"AddStudent","Args":["1004","Ravi","Singh","ravi213@gmail.com","998874845","House no. 32","Ldh"]}'

sleep 2



echo "###########################################"
echo "ADDING SECOND STUDENT"
echo "###########################################"

sleep 3

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C mychannel -n basic --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"AddStudent","Args":["1005","Vivek","Singh","vivek213@gmail.com","954474845","House no.454","UP"]}'


sleep 2

echo "###########################################"
echo "ADDING THIRD STUDENT"
echo "###########################################"

sleep 3

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C mychannel -n basic --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"AddStudent","Args":["1006","Sumit","Pundir","sumit213@gmail.com","943355525","House no. 46","Chd"]}'

sleep 5

echo "###########################################"
echo "ALREADY EXISTING studentID WITH PROVIDED studentID CHECK "
echo "###########################################"

sleep 3

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C mychannel -n basic --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"AddStudent","Args":["1004","Prince","Kumar","prince213@gmail.com","9478778","House no. 767","CHd"]}'


sleep 5

echo "###########################################"
echo "1). INVOKE EditStudent function of chaincode "
echo "###########################################"

sleep 3

echo "###########################################"
echo "EDIT DETAILS OF ALREADY EXISTING/ADDED STUDENT" 
echo "###########################################"

echo "CHANGING FIRST NAME AND LAST NAME OF STIDENT WITH GIVEN STUDENTID"

sleep 3

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C mychannel -n basic --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"EditStudent","Args":["1003","NAVEEN","SHARMA","prince213@gmail.com","9478778","House no. 767","CHd"]}'


sleep 3

echo "###########################################"
echo "VIEW RECORDS OF ALL STUDENTS   (ViewAllStudents function)" 
echo "###########################################"

sleep 3
peer chaincode query -C mychannel -n basic -c '{"Args":["ViewAllStudents"]}'


sleep 2

echo "###########################################"
echo "VIEW RECORD OF A SINGLE STUDENT (ViewSingleStudent function)" 
echo "###########################################"

sleep 3

peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C mychannel -n basic --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"ViewSingleStudent","Args":["1005"]}'

