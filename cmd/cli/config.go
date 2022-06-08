package cli

import (
	"io/ioutil"
	"log"
	"path/filepath"

	"gopkg.in/yaml.v3"
)

// User type to be used during template processing.
type User struct {
	UserName   string `yaml:"username"`
	FullName   string `yaml:"name"`
	Email      string `yaml:"email"`
	GithubUser string `yaml:"github"`
	GitlabUser string `yaml:"gitlab"`
}

// DotFile represents a single dotfile template config to be rendered.
type DotFile struct {
	Output   string
	Template string
}

// DotFiles is the full list of files that has been configured.
type DotFiles struct {
	Path  string
	Files []DotFile
}

// Config data that's read after initialization.
type Config struct {
	User     User
	DotFiles DotFiles `yaml:"dotfiles"`
}

// HasGithub `true` if a GitHub user is configured, `false` otherwise.
func (u *User) HasGithub() bool {
	return len(u.GithubUser) > 0
}

// HasGitlab `true` if a GitLab user is configured, `false` otherwise.
func (u *User) HasGitlab() bool {
	return len(u.GitlabUser) > 0
}

// NewConfig creates an instance of the configuration data using the file read
// from the configuration directory.
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
