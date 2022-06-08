PROJECT := "dotfiles"

M = $(shell printf "\033[34;1m▶\033[0m")

all: dotfiles setup

-include cmd/build.mk

dotfiles: ; $(info $(M) Running ansible dotfiles playbook...)
	@ansible-playbook -i inventory/hosts dotfiles.yml

setup: ; $(info $(M) Running ansible setup playbook...)
	@ansible-playbook -i inventory/hosts setup.yml

# additional docker builds for testing repo as GH dotfiles for codespaces
image: ; $(info $(M) Building docker image...)
	@docker build -t dotfiles .

container: ; $(info $(M) Starting dotfiles container...)
	@docker run -it --rm dotfiles /bin/bash

.PHONY: all build debug release clean
