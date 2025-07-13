- Set up dev flake
Digital Ocean
- Created a PAT
- Created an SSH Key 
- Set up secrets and .env importing in flake
Terraform
- Created provider.tf
- Completed the NGINX loadbalancer tutorial
Homelab
- Successfully created a nixos image and added to digital ocean
- Created basic Terraform configuration for deploying a single nixos dropplet
- Terraformed homelab configuration 
- Note: DO Spaces configuration use the spaces key name, but the terraform s3 backend uses the aws key name
CICD
- Created branches, chain workflows
- Figure out bootstrapping process - switching to manual 

---

Day 2
- Set up outputs.tf in main while preparing to set up [[Colmena]]
	- aws s3 cp s3://homelab-state/output.json output.json \
  --endpoint-url https://nyc3.digitaloceanspaces.com
	- nix run github:zhaofengli/colmena -- apply
- Settup github workflow to use cachix
- Trying [[comin]] instead of Colmena for a simpler pull-model approach
	-   https://github.com/nlewo/comin?tab=readme-ov-file

---

- [[Kubernetes (K8s)|Kubernetes]] 
- [[Talos Linux]]

Omnivore or Wallabag
Linkding
Jellyfin + Rclone
Invidious? 
Music
PiHole 

---

