package main

import "plugin"

func main() {
	p, err := plugin.Open("./demoapp.so")
	if err != nil {
		panic(err)
	}
	s, err := p.Lookup("PrintInfo")
	if err != nil {
		panic(err)
	}
	s.(func())()
}
