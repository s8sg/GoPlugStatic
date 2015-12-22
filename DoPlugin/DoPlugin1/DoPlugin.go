package DoPlugin1

import (
	"fmt"
	"github.com/swarvanusg/GoPlugStatic/PluginReg"
)

type DoPlugin1 struct {
	do int
}

func (doPlug DoPlugin1) Do() int {
	fmt.Printf("I Do")
	return doPlug.do
}

func init() {
	doPlug := DoPlugin1{5}
	PluginReg.RegisterDo(2, doPlug)
}
