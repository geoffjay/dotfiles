package cli

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
	"text/template"

	"gopkg.in/yaml.v3"
)

// Build is used to control functionality based on build type
var Build string

// Run executes the main command.
func Run() {
	if len(os.Args) == 1 {
		help()
	}

	args := os.Args[1:]
	cmdArgs := args[1:]

	// what should this do?
	// - render templates
	// - write files from project to $HOME
	// - check $HOME for changes to files, use checksum?

	config := NewConfig()
	dotEnv := NewDotEnv(&config.User)

	switch args[0] {
	case "version":
		fmt.Println("v0.1.1-beta")
		os.Exit(0)
	case "check":
		checkCmd(cmdArgs, dotEnv, config)
	case "edit":
		editCmd(cmdArgs, dotEnv, config)
	case "init":
		initCmd(cmdArgs, dotEnv, config)
	case "update":
		updateCmd(cmdArgs, dotEnv, config)
	case "build-type":
		fmt.Printf("build type: %s\n", Build)
	case "debug":
		yamlConfig, _ := yaml.Marshal(config)
		fmt.Printf(`Execution environment

User:		%s
Home:		%s
Template path:	%s
Config path:	%s

Configuration:

%+v
`, os.Getenv("USER"), os.Getenv("HOME"), getTemplateDir(), getConfigDir(), string(yamlConfig))
	default:
		help()
	}
}

func help() {
	usage := `dotfiles is a tool for managing user config.

Usage:

	dotfiles <command>

The commands are:

	check		test if local changes will be overridden by an update
	edit		open the $EDITOR to modify dotfile templates
	init		initialize the configuration environment
	update		compile the configuration environment from templates
`

	fmt.Print(usage)
	os.Exit(1)
}

func checkCmd(args []string, env *DotEnv, config *Config) {
	if env == nil {
		panic("`check' needs environment")
	}
	log.Fatal("`check' has not been implemented yet")
}

func editCmd(args []string, env *DotEnv, config *Config) {
	if env == nil {
		panic("`edit' needs environment")
	}
	log.Fatal("`edit' has not been implemented yet")
}

func initCmd(args []string, env *DotEnv, config *Config) {
	if env == nil {
		panic("`init' needs environment")
	}
	log.Fatal("`init' has not been implemented yet")
}

func updateCmd(args []string, env *DotEnv, config *Config) {
	var err error

	if env == nil {
		log.Fatal("`update' needs environment")
	}

	for _, dotfile := range config.DotFiles.Files {
		var tmpl *template.Template
		var output *os.File

		if tmpl, err = template.ParseFiles(filepath.Join(env.TemplateDir, dotfile.Template)); err != nil {
			log.Fatal(err)
		}

		filename := filepath.Join(os.Getenv("HOME"), dotfile.Output)
		dir, _ := filepath.Split(filename)
		if _, err = os.Stat(dir); os.IsNotExist(err) {
			_ = os.MkdirAll(dir, 0755)
		}

		if output, err = os.OpenFile(filename, os.O_WRONLY|os.O_CREATE|os.O_TRUNC, 0644); err != nil {
			log.Fatal(err)
		}

		err = tmpl.Execute(output, env)
		if err != nil {
			log.Fatal(err)
		}
	}
}
