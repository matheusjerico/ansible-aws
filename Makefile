.PHONY: help
help: ## Show help menu
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-35s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: terraform-plan
terraform-plan: ## Execute "terraform plan -out=plan"
	terraform -chdir=provisioning plan -out=plan

.PHONY: terraform-apply
terraform-apply: ## Execute "terraform apply "plan""
	terraform -chdir=provisioning apply "plan"

.PHONY: terraform-state-list
terraform-state-list: ## Execute "terraform state list"
	terraform -chdir=provisioning state list

.PHONY: terraform-destroy
terraform-destroy: ## Execute terraform destroy -auto-approve"
	@echo "Waiting 20 seconds... If you want to cancel, press: ctrl+c"
	@sleep 20
	terraform -chdir=provisioning destroy -auto-approve

.PHONY: ansible-apply
ansible-apply: ## Install packages in AWS instance using Ansible Playbooks
	@ansible-inventory -i install/aws_ec2.yml --graph
	ansible-playbook -i install/aws_ec2.yml install/main.yml

.DEFAULT_GOAL := help                                                          
