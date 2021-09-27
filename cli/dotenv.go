package cli

import (
	"fmt"
	"runtime"
	"strings"
	"time"
)

// DotEnv contains the environment used while processing the templates.
type DotEnv struct {
	AllowRootX  bool
	OS          string
	TemplateDir string
	User        *User
}

// WriteHeader generates a header for the template where a filetype can be
// provided.
func (d *DotEnv) WriteHeader(filetype string) string {
	elements := []string{
		"# vim:set ts=2 sw=2:",
		fmt.Sprintf("# vim:set ft=%s", filetype),
		"# Auto generated file, do not edit!",
		fmt.Sprintf("# Updated at %s", time.Now()),
	}
	return strings.Join(elements, "\n")
}

// NewDotEnv constructs a new instance of a template enviroment for template
// processing.
func NewDotEnv(user *User) *DotEnv {
	// TODO: user should be read from config
	return &DotEnv{
		AllowRootX:  false,
		OS:          runtime.GOOS,
		TemplateDir: getTemplateDir(),
		User:        user,
	}
}
