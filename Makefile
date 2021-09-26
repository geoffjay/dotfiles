all: build

build: debug

debug:
	@go build -tags debug -o dotfiles main.go

release:
	@go build -tags release -o dotfiles main.go

clean:
	@rm dotfiles

test: build
	@HOME=$(shell pwd) TEMPLATE_DIR=templates/ CONFIG_DIR=config/ ./dotfiles debug

.PHONY: all build debug release clean
