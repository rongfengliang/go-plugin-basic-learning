package main

import (
	"log"
	"plugin"
)

// MyGenerateID myGenerateID
type MyGenerateID interface {
	GenerateID() string
}

var myGenerateID MyGenerateID

func init() {
	p, err := plugin.Open("./id.so")
	if err != nil {
		panic(err)
	}
	// init plugin for shortid
	s, err := p.Lookup("New")
	if err != nil {
		panic("init plugin error")
	}
	myid := s.(func(workerid uint8, seed uint64) interface{})(2, 2000)
	myGenerateID = myid.(MyGenerateID)
}

func main() {
	for i := 0; i < 10; i++ {
		log.Println("generate id:", myGenerateID.GenerateID())

	}
}
