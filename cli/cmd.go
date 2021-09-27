package cli

import (
	"fmt"
	"log"
	"os"
	"path/filepath"
	"text/template"

	"github.com/go-git/go-git/v5"
	"gopkg.in/yaml.v3"
)

// Build is used to control functionality based on build type
var Build string

// Run executes the main command.
func Run() {
	if len(os.Args) == 1 {
		help([]string{})
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
		fmt.Println("v0.2.0")
		os.Exit(0)
	case "check":
		checkCmd(dotEnv, config)
	case "edit":
		editCmd(dotEnv, config)
	case "init":
		initCmd()
	case "reset":
		resetCmd()
	case "update":
		updateCmd(dotEnv, config)
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
		help(cmdArgs)
	}
}

func help(args []string) {
	usage := `dotfiles is a tool for managing user config.

Usage:

	dotfiles <command>

The commands are:

	check		test if local changes will be overridden by an update
	edit		open the $EDITOR to modify dotfile templates
	init		initialize the configuration environment
	reset		remove all files that were created by the initialization
	update		compile the configuration environment from templates
`

	fmt.Print(usage)
	os.Exit(1)
}

func checkCmd(env *DotEnv, config *Config) {
	if env == nil {
		panic("`check' needs environment")
	}
	log.Fatal("`check' has not been implemented yet")
}

func editCmd(env *DotEnv, config *Config) {
	if env == nil {
		panic("`edit' needs environment")
	}
	log.Fatal("`edit' has not been implemented yet")
}

func initCmd() {
	home := os.Getenv("HOME")

	// setup the cache directory if it doesn't already exist
	cacheDir := filepath.Join(home, ".cache")
	if _, err := os.Stat(cacheDir); os.IsNotExist(err) {
		err := os.MkdirAll(cacheDir, 0755)
		CheckIfError(err)
	}

	// clone this repository as the template cache
	path := filepath.Join(cacheDir, "dotfiles")
	_, err := git.PlainClone(path, false, &git.CloneOptions{
		URL:      "https://github.com/geoffjay/dotfiles",
		Progress: os.Stdout,
	})
	CheckIfError(err)

	// setup the configuration
	configDir := filepath.Join(home, ".config", "dotfiles")
	if _, err := os.Stat(configDir); os.IsNotExist(err) {
		err := os.MkdirAll(configDir, 0755)
		CheckIfError(err)
	}

	configSrc := filepath.Join(cacheDir, "dotfiles", "config", "dotfiles.yml")
	configDst := filepath.Join(configDir, "dotfiles.yml")
	err = CopyFile(configSrc, configDst)
	CheckIfError(err)

	// setup the templates
	templateDir := filepath.Join(home, ".local", "share", "dotfiles")
	if _, err := os.Stat(templateDir); os.IsNotExist(err) {
		err := os.MkdirAll(templateDir, 0755)
		CheckIfError(err)
	}

	templateSrc := filepath.Join(cacheDir, "dotfiles", "templates")
	templateDst := filepath.Join(templateDir, "templates")
	err = CopyDir(templateSrc, templateDst)
	CheckIfError(err)
}

func resetCmd() {
	home := os.Getenv("HOME")

	err := RemoveGlob(filepath.Join(home, ".cache", "dotfiles"))
	CheckIfError(err)

	err = RemoveGlob(filepath.Join(home, ".config", "dotfiles"))
	CheckIfError(err)

	err = RemoveGlob(filepath.Join(home, ".local", "share", "dotfiles"))
	CheckIfError(err)
}

func updateCmd(env *DotEnv, config *Config) {
	var err error

	if env == nil {
		panic("`update' needs environment")
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
