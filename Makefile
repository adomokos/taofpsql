-include .env.$(or $(APP_ENV),dev)
export

APP_ENV ?=dev

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

.PHONY: run
run: ## Runs the specified (FILE) SQL script
		PGPASSWORD='$(POSTGRES_PASSWORD)' PGHOST=$(POSTGRES_HOST) \
		 psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) --no-psqlrc \
		 -f $(FILE)

.PHONY: run-with-args
run-with-args: ## Runs sql file with passed-in arguments
		PGPASSWORD='$(POSTGRES_PASSWORD)' PGHOST=$(POSTGRES_HOST) \
		 psql -U $(POSTGRES_USER) -d $(POSTGRES_DB) --no-psqlrc \
		 --set n=1 --set name=Aerosmith \
		 -P format=html \
		 -f 04-small-app/psql-input-args.sql

help: ## Prints this help message
	@grep -h -E '^[a-zA-Z0-9\._-]+:.*?## .*$$' $(MAKEFILE_LIST) |\
		sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.DEFAULT_GOAL := help
