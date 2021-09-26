package cli

import (
	"io/ioutil"
	"log"
	"os"
	"path/filepath"

	"gopkg.in/yaml.v3"
)

type User struct {
	UserName   string `yaml:"username"`
	FullName   string `yaml:"name"`
	Email      string `yaml:"email"`
	GithubUser string `yaml:"github"`
	GitlabUser string `yaml:"gitlab"`
}

type DotFile struct {
	Output   string
	Template string
}

type DotFiles struct {
	Path  string
	Files []DotFile
}

type Config struct {
	User     User
	DotFiles DotFiles `yaml:"dotfiles"`
}

func getConfigDir() string {
	dir := os.Getenv("CONFIG_DIR")
	if dir == "" {
		switch Build {
		case "debug":
			dir = "config"
		case "release":
			dir = filepath.Join(os.Getenv("HOME"), ".config", "dotfiles")
		}
	}
	return dir
}

func (u *User) HasGithub() bool {
	return len(u.GithubUser) > 0
}

func (u *User) HasGitlab() bool {
	return len(u.GitlabUser) > 0
}

func NewConfig() *Config {
	var err error
	var data []byte
	var config Config

	if data, err = ioutil.ReadFile(filepath.Join(getConfigDir(), "dotfiles.yml")); err != nil {
		log.Fatal(err)
	}

	if err = yaml.Unmarshal(data, &config); err != nil {
		log.Fatal(err)
	}

	return &config
}
