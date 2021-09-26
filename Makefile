PROJECT := "dotfiles"

M = $(shell printf "\033[34;1m▶\033[0m")

all: build

build: debug

debug: ; $(info $(M) Building a debug binary of $(PROJECT)...)
	@go build -tags debug -o dotfiles main.go

release: ; $(info $(M) Building a release binary of $(PROJECT)...)
	@go build -tags release -o dotfiles main.go

clean: ; $(info $(M) Removing build files... )
	@rm dotfiles

check: build; $(info $(M) Testing the development environment...)
	@HOME=$(shell pwd) TEMPLATE_DIR=templates/ CONFIG_DIR=config/ ./dotfiles debug

test: ; $(info $(M) Running tests...)
	@go test -v -tags debug,integration ./...

.PHONY: all build debug release clean
