package student

import (
	"encoding/json"
	"fmt"
	"log"
	"student-record-system/src/schema"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

type StudentChaincode struct {
	contractapi.Contract
}

// Check whether student with given ID exists in the ledger.
func (s *StudentChaincode) StudentExists(ctx contractapi.TransactionContextInterface, studentID string) (bool, error) {
	studentBytes, err := ctx.GetStub().GetState(studentID)
	if err != nil {
		return false, fmt.Errorf("failed to read student %s from world state. %v", studentID, err)
	}

	return studentBytes != nil, nil
}

//add new student record details
func (s *StudentChaincode) AddStudent(ctx contractapi.TransactionContextInterface, studentID string, firstname string, lastname string, email string, mobile string, address string, city string) (string, error) {

	//checking whether student with studentID already exists in the ledger
	exists, err := s.StudentExists(ctx, studentID)
	if err != nil {
		return "", fmt.Errorf("student with %s id not exists: %v", studentID, err)
	}
	if exists {
		return "", fmt.Errorf("student already exists: %s", studentID)
	}

	// passing student details parameters to studentSchema struct
	request := schema.StudentSchema{
		Id:        studentID,
		FirstName: firstname,
		LastName:  lastname,
		Email:     email,
		Mobile:    mobile,
		Address:   address,
		City:      city,
	}

	// change struct data request to json bytes
	jsonData, err := json.Marshal(request)
	if err != nil {
		log.Println("error in marshalling", err)
		return "", err
	}

	// adding student details into ledger
	err = ctx.GetStub().PutState(studentID, jsonData)
	// if any error
	if err != nil {
		log.Println("error in adding in ledger", err)
		return "", err
	} else {
		log.Println("student data has been added")
	}

	return string(jsonData), nil
}

// ViewSinglestudent returns the data stored in the world state with given id.
func (s *StudentChaincode) ViewSingleStudent(ctx contractapi.TransactionContextInterface, studentID string) (*schema.StudentSchema, error) {
	studentJson, err := ctx.GetStub().GetState(studentID)
	if err != nil {
		return nil, fmt.Errorf("failed to read from world state: %v", err)
	}
	if studentJson == nil {
		return nil, fmt.Errorf("the student with %s does not exist", studentID)
	}

	//creating variable of type studentSchema to store fetched student details
	var student schema.StudentSchema
	// converting student data into struct data
	err = json.Unmarshal(studentJson, &student)
	if err != nil {
		return nil, err
	}

	return &student, nil
}

//view all students stored in ledger
func (s *StudentChaincode) ViewAllStudents(ctx contractapi.TransactionContextInterface) ([]*schema.StudentSchema, error) {
	resultsIterator, err := ctx.GetStub().GetStateByRange("", "")
	if err != nil {
		return nil, err
	}
	defer resultsIterator.Close()

	var students []*schema.StudentSchema
	//iterating over all records one by one
	for resultsIterator.HasNext() {
		queryResponse, err := resultsIterator.Next()
		if err != nil {
			return nil, err
		}

		//storing student records in variable student o type studentSchema
		var student schema.StudentSchema
		// //data into student struct data
		err = json.Unmarshal(queryResponse.Value, &student)
		if err != nil {
			return nil, err
		}
		// appending cuurently fetched student data in students array
		students = append(students, &student)
	}

	return students, nil
}

//Edit details of already exisiting student
func (s *StudentChaincode) EditStudent(ctx contractapi.TransactionContextInterface, studentID string, firstname string, lastname string, email string, mobile string, address string, city string) error {
	// checking whether student exists in ledger or not
	exists, err := s.StudentExists(ctx, studentID)
	if err != nil {
		return err
	}
	if !exists {
		return fmt.Errorf("the student %s does not exist", studentID)
	}

	// overwriting original student details with new student details
	student := schema.StudentSchema{
		Id:        studentID,
		FirstName: firstname,
		LastName:  lastname,
		Email:     email,
		Mobile:    mobile,
		Address:   address,
		City:      city,
	}

	//marshalling new details of student into bytes
	studentJSON, err := json.Marshal(student)
	if err != nil {
		log.Println("error in updating student data ")
		return err
	} else {
		log.Println("student data has been updated")
	}

	//updating new student detais in ledger
	return ctx.GetStub().PutState(studentID, studentJSON)
}
