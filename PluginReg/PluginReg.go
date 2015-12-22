package PluginReg

import ()

type DoPlugin interface {
	Do() int
}

type FooPlugin interface {
	Foo() int
}

var doPluginReg map[int]DoPlugin
var fooPluginReg map[int]FooPlugin

func RegisterDo(key int, val DoPlugin) {
	doPluginReg[key] = val
}

func RegisterFoo(key int, val FooPlugin) {
	fooPluginReg[key] = val
}

func PluginRegStart() {
	for _, dovalue := range doPluginReg {
		dovalue.Do()

	}
	for _, foovalue := range fooPluginReg {
		foovalue.Foo()
	}
}

func init() {
	doPluginReg = make(map[int]DoPlugin)
	fooPluginReg = make(map[int]FooPlugin)
}
