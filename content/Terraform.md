Terraform is a source-available [[Infrastructure as Code (IaC)]] tool that allows users to define, provision, and manage infrastructure comments like virtual machines, networks, databases, DNS entries, [[Kubernetes (K8s)]], and SaaS integrations using [[Declarative Configuration]] files rather than manual setup processes. 

> Note:  Hashicorp switched Terraform to a Business Source License 1.1

## Useful Commands
- `terraform init` is required to initialize the directory
- `terraform fmt` will clean up the code visually
- `terraform validate` will validate the code to ensure it's functional, checking for invalid or missing requirements 
- `terraform plan` prints what'll be created, destroyed, or modified on deployment
	- Add argument `-out <PATH>` to create a plan file
	- IMPORTANT: The saved plan doesn't encrypt data like API keys, and should be encrypted if shared
- `terraform apply` to apply what's planned
	- Add argument `<PATH>` to apply from a create plan

> Note: Any `terraform` command can use `-chdir=path/` to use configs in sub directories while still accessing files in the current directory, such as secrets. 