---
aliases:
  - Helm Chart
---
Helm is a package manager for [[Kubernetes (K8s)|Kubernetes]], allowing for the packaging of Kubernetes resources (deployments, services, etc) into single units called Charts. 
- Charts: Package for a specific Kubernetes application
- Repository: Place where Helm Charts are collected and shared
- Release: An instance of a chart running in a Kubernetes cluster

Commands
- `helm search hub <app>` and `helm search repo <app>` to find a chart with a fuzzy search.
	- `helm repo add <address>` to add a new repo
- `helm install <custom release name> <repo/chart>` to install an app




---
- Docs: https://helm.sh/docs/intro/using_helm/
