VERSIONS := $(shell find . -name Dockerfile -exec dirname {} \;)
.PHONY: all update build test

all: update build

update:
	./update.rb

# ensures that all generated files are up to date in CI
validate: update
	git status
	test -z "$$(git status --porcelain)"

build:
	./build.rb

test:
	./test.rb
