package FooPlugin1

import (
	"fmt"
	"github.com/swarvanusg/GoPlugStatic/PluginReg"
)

type FooPlugin1 struct {
	foo int
}

func (fooPlug FooPlugin1) Foo() int {
	fmt.Printf("I Foo")
	return fooPlug.foo
}

func init() {
	fooPlug := FooPlugin1{3}
	PluginReg.RegisterFoo(3, fooPlug)
}
