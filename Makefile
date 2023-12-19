.DEFAULT_GOAL := help

DOCKERFILE_PATH="./compose/docker-compose.yml"

.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: providers
providers: ## Initilize terraform project
	@docker compose -f "${DOCKERFILE_PATH}" run --rm repositories terraform providers

.PHONY: init
init: ## Initilize terraform project
	@docker compose -f "${DOCKERFILE_PATH}" run --rm repositories terraform init

.PHONY: plan
plan: ## Check infrastructure to deploy
	@docker compose -f "${DOCKERFILE_PATH}" run --rm repositories terraform plan

.PHONY: fmt
fmt: ## Format terraform files
	@docker compose -f "${DOCKERFILE_PATH}" run --rm repositories terraform fmt

.PHONY: apply
apply: ## Apply infrastructure with auto approve
	@docker compose -f "${DOCKERFILE_PATH}" run --rm repositories terraform apply --auto-approve

.PHONY: destroy
destroy: ## Destroy infrastructure
	@docker compose -f "${DOCKERFILE_PATH}" run --rm repositories terraform destroy

.PHONY: output
output: ## Destroy infrastructure
	@docker compose -f "${DOCKERFILE_PATH}" run --rm repositories terraform output


