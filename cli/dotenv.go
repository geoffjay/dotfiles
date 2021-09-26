package cli

import (
	"fmt"
	"os"
	"runtime"
	"strings"
	"time"
)

type DotEnv struct {
	AllowRootX  bool
	OS          string
	TemplateDir string
	User        *User
}

func getTemplateDir() string {
	dir := os.Getenv("TEMPLATE_DIR")
	if dir == "" {
		dir = "templates"
	}
	return dir
}

func (d *DotEnv) WriteHeader(filetype string) string {
	elements := []string{
		"# vim:set ts=2 sw=2:",
		fmt.Sprintf("# vim:set ft=%s", filetype),
		"# Auto generated file, do not edit!",
		fmt.Sprintf("# Updated at %s", time.Now()),
	}
	return strings.Join(elements, "\n")
}

func NewDotEnv(user *User) *DotEnv {
	// TODO: user should be read from config
	return &DotEnv{
		AllowRootX:  false,
		OS:          runtime.GOOS,
		TemplateDir: getTemplateDir(),
		User:        user,
	}
}
