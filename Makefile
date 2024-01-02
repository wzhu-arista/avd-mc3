.PHONY: help
help: ## Display help message
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: deploy
deploy: ## Complete AVD & cEOS-Lab Deployment
	@echo -e "\n############### \e[1;30;42mStarting cEOS-Lab topology\e[0m ###############\n"
	@sudo containerlab deploy -t topology.yml
	@echo -e "\n############### \e[1;30;42mGenerating and deploying switch configuration\e[0m ###############\n"
	@ansible-playbook playbooks/deploy.yml --flush-cache
	@echo -e "\n############### \e[1;30;42mConfiguring client nodes\e[0m ###############\n"
	@sudo bash host_l3_config/l3_build.sh
	# @echo -e "\n############### \e[1;30;42mConfiguring Servers\e[0m ###############\n"
	# @ansible-playbook playbooks/server.yml
	@echo -e "\n############### \e[1;30;42mcEOS-Lab Topology\e[0m ###############\n"
	@sudo containerlab inspect -t topology.yml
	@echo -e "\n############### \e[1;30;42mcEOS-Lab Deployment Complete\e[0m ###############\n"

.PHONY: destroy
destroy: ## Delete cEOS-Lab Deployment and AVD generated config and documentation
	@echo -e "\n############### \e[1;30;42mWiping nodes and deleting AVD configuration\e[0m ###############\n"
	@sudo containerlab destroy -t topology.yml --cleanup
	@rm -rf .topology.yml.bak config_backup/ snapshots/ reports/ documentation/ intended/
