package main

import (
	"log"

	"github.com/teris-io/shortid"
)

// MyID myid
type MyID struct {
	*shortid.Shortid
}

// New create myid instance
func New(workerid uint8, seed uint64) interface{} {
	log.Printf("init info:%d,%d", workerid, seed)
	shortid, err := shortid.New(workerid, shortid.DefaultABC, seed)
	if err != nil {
		log.Println("some wrong", err)
	}
	return MyID{
		Shortid: shortid,
	}
}

// GenerateID generateID
func (myid MyID) GenerateID() string {
	id, err := myid.Generate()
	if err != nil {
		log.Println("generate id error")
	}
	return id
}

func main() {}
