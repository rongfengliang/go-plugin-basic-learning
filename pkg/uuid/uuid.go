package main

import (
	"log"

	"github.com/google/uuid"
)

// MyID2 myid2
type MyID2 struct {
}

// New create myid instance
func New(workerid uint8, seed uint64) interface{} {
	log.Printf("ignore init info:%d,%d", workerid, seed)
	return MyID2{}
}

// GenerateID generateID
func (myid MyID2) GenerateID() string {
	id, err := uuid.NewUUID()
	if err != nil {
		log.Println("generate id error")
	}
	return id.String()
}

func main() {}
