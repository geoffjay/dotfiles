package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"text/template"
	"time"

	"gopkg.in/yaml.v3"
)

type DotEnv struct {
	GenHeader   string
	OS          string
	AllowRootX  bool
	TemplateDir string
}

type DotFile struct {
	Output   string
	Template string
}

type Config struct {
	Dotfiles []DotFile
}

func NewDotEnv() *DotEnv {
	// TODO: figure out modeline for different filetypes
	elements := []string{
		"# vim: set ts=2 sw=2 :",
		"# vim: set ft=sh",
		"# Auto generated file, do not edit!",
		fmt.Sprintf("# Updated at %s", time.Now()),
	}
	header := strings.Join(elements, "\n")
	return &DotEnv{
		OS:          runtime.GOOS,
		GenHeader:   header,
		AllowRootX:  false,
		TemplateDir: getTemplateDir(),
	}
}

func main() {
	program := os.Args[0]
	args := os.Args[1:]

	if len(args) == 0 {
		log.Fatalf("%s requires an argument", program)
	}

	// what should this do?
	// - render templates
	// - write files from project to $HOME
	// - check $HOME for changes to files, use checksum?

	dotEnv := NewDotEnv()

	switch args[0] {
	case "check":
		check(dotEnv)
	case "update":
		update(dotEnv)
	default:
		help()
	}
}

func getTemplateDir() string {
	dir := os.Getenv("TEMPLATE_DIR")
	if dir == "" {
		dir = "templates"
	}
	return dir
}

func help() {
	log.Println("do the right thing")
}

func check(env *DotEnv) {
	if env == nil {
		panic("check needs environment")
	}
	log.Println("check")
}

func update(env *DotEnv) {
	var err error
	var data []byte
	var config Config

	if env == nil {
		log.Fatal("update needs environment")
	}

	if data, err = ioutil.ReadFile(filepath.Join(env.TemplateDir, "dotfiles.yml")); err != nil {
		log.Fatal(err)
	}

	if err = yaml.Unmarshal(data, &config); err != nil {
		log.Fatal(err)
	}

	for _, dotfile := range config.Dotfiles {
		var tmpl *template.Template
		var output *os.File

		if tmpl, err = template.ParseFiles(filepath.Join(env.TemplateDir, dotfile.Template)); err != nil {
			log.Fatal(err)
		}

		filename := filepath.Join(os.Getenv("HOME"), dotfile.Output)
		dir, _ := filepath.Split(filename)
		if _, err = os.Stat(dir); os.IsNotExist(err) {
			err = os.MkdirAll(dir, 0755)
		}

		if output, err = os.OpenFile(filename, os.O_WRONLY|os.O_CREATE, 0644); err != nil {
			log.Fatal(err)
		}

		err = tmpl.Execute(output, env)
		if err != nil {
			log.Fatal(err)
		}
	}
}
