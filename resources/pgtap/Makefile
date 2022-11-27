mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))

VERSION ?= 0.1.0

.PHONY: build
build: ## Builds the docker image with pgtap
	docker build -t adomokos/postgres-pgtap:$(VERSION) .

.PHONY: help
help: ## Display this message
	@grep -h -E '^[a-zA-Z0-9\._-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.DEFAULT_GOAL := help
