package main

import (
	"log"

	"student-record-system/src/student"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

func main() {
	//creating studentChaincode
	StudentChaincode, err := contractapi.NewChaincode(&student.StudentChaincode{})
	if err != nil {
		log.Panicf("Error creating student chaincode: %v", err)
	}

	//starting studentChainccode
	if err := StudentChaincode.Start(); err != nil {
		log.Panicf("Error starting chaincode: %v", err)
	}
}
