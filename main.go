package main

import (
	"openssl"
	"fmt"
)

func main()  {
	HelloWorld()
}

func HelloWorld()  {
	status, version := openssl.Status()
	fmt.Println("status: ", status)
	fmt.Println("version: ",version)
}