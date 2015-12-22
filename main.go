package main

import (
	_ "github.com/swarvanusg/GoPlugStatic/DoPlugin/DoPlugin1"
	_ "github.com/swarvanusg/GoPlugStatic/FooPlugin/FooPlugin1"
	"github.com/swarvanusg/GoPlugStatic/PluginReg"
)

func main() {
	PluginReg.PluginRegStart()
}
