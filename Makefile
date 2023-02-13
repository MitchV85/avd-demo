### Generic Variables
# SHELL := /bin/zsh
SHELL := /bin/bash

.PHONY: help
help: ## Display help message (*: main entry points / []: part of an entry point)
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'



################################################################################
# Ansible  - Build & Deploy AVD Configs & Reset Lab to Base Configs
################################################################################

.PHONY: build-dc1
build-dc1: ## Run ansible playbook to build AVD config files
	ansible-playbook playbooks/dc1.yml -i inventories/DC1/inventory.yml --tags build

.PHONY: build-dc2
build-dc2: ## Run ansible playbook to build AVD config files
	ansible-playbook playbooks/dc2.yml -i inventories/DC2/inventory.yml --tags build

.PHONY: deploy-dc1
deploy-dc1: ## Build and Deploy AVD config files - eAPI push
	ansible-playbook playbooks/dc1.yml -i inventories/DC1/inventory.yml --tags deploy

.PHONY: deploy-dc2
deploy-dc2: ## Build and Deploy AVD config files - eAPI push
	ansible-playbook playbooks/dc2.yml -i inventories/DC2/inventory.yml --tags deploy

.PHONY: validate-dc1
validate-dc1: ## Check the current state of the Fabric and Generate Report
	ansible-playbook playbooks/dc1.yml -i inventories/DC1/inventory.yml --tags checkstate

.PHONY: validate-dc2
validate-dc2: ## Check the current state of the Fabric and Generate Report
	ansible-playbook playbooks/dc1.yml -i inventories/DC2/inventory.yml --tags checkstate

.PHONY: reset-lab
reset-lab: ## Run ansible playbook to reset Lab to base configs
	ansible-playbook playbooks/apply_base_configs.yml -i inventory.yml

################################################################################
# Start/Stop ContainerLab
################################################################################
.PHONY: start-lab
start-lab: ## Start Containerlab
	sudo clab deploy -t clab/lab.yaml --reconfigure

.PHONY: stop-lab
stop-lab: ## Stop ContainerLab
	sudo clab destroy -t clab/lab.yaml

.PHONY: inspect-lab
inspect-lab: ## Inspect ContainerLab
	sudo clab inspect -a

.PHONY: cleanstop-lab
cleanstop-lab: ## Stop ContainerLab
	sudo clab destroy -t clab/lab.yaml --cleanup

################################################################################
# Onboard Devices into CVaaS
################################################################################
# .PHONY: onboard-devices
# onboard-devices: ## Onboard Devices into CVaaS
# 	ansible-playbook playbooks/onboard_to_cvaas.yml