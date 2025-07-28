## 1. DevOps Introduction
### DevOps Overview
Lifecycle:
- Test Driven
- Continuously Built, Tested, Released, Monitored
- Dev: Plan, Code, Build Test,
- Ops: Release, Deploy, Operate, Monitor
- Agile covers plan through build.

### OCI DevOps Service
- CI/CD & DevOps as a Service
- Store Code, Build / Test / Deploy, Automation, Orchestration, HA
- Automation, Scalability, Integration and Interoperability, Low Risk, Low Cost


## 2. Microservices and Containerization
- Microservice: Architecture wherein application tasks are broken down into the simplest unit. Can be multilingual, loosely coupled, and easier to maintain and redeploy. Easier to scale and be failure resistant. 
- 12 Factor Apps Method
	- 1. Single Codebase for each app
	- 2. Dependencies should be tracked by package managers
	- 3. Configuration should be externalized from the code
	- 4. Backing Services should be easy to swap without modifying the codebase, only config change
	- 5. Searate Build, Release, and Run
	- 6. Processes - services should be stateless and easily horizontally scaled, never relly on caged memory
	- 7. Port Binding 
	- 8. Concurrency -- scale horizontally rather than vertical 
	- 9. Disposability -  System shouldn't be impacted by containers spinning up or down 
	- 10. Dev/Prod Parity 
	- 11. Logs should be streamed and monitored constantly rather than dumped in a log file
	- 12. Admin Process
- Drawbacks:
	- Complex Architecture 
	- Expensive to build and maintain 
	- Requires cultural changes
	- Harder debugging problems 
	- Global testing is difficult 
- Containerization
	- Form of virtualization, running applications isolated userspaces sharing an underlying OS on top of a container engine. 
	- Fully packaged and self contained application environment 
	- Different from VMs in that Containers share the OS kernal rather than running everything itself
	- Benefits: Portable, Agile, Fast, Fault Isolation, Efficiency, Ease of Management, and Secure
- Docker Components
	- Docker Client - for interfacing with docker engine, either local or remote throug shell
	- Daemon = Remote Background process running reources, communicated with from the Client via REST API 
	- Registry -  Repository of docker images 
	- Commands
		- `run <image name>` to create container
			- `-d` to run in the background, `-p` to forward container port to host port
		- `start|stop|restart|inspect|logs <container_name|ID`
		- `ps` list containers
		- `rm <container_name|ID` to remove
		- `image pull <image name>` to get image
		- `build -t <dockerfile path>` to build image
		- `commit <container> <new image name>` to build from container
		- `tag <source image tag> <target image tag>`
		- `login` and `push` to add to registry
		- `image ls` 
		- `image remove` 
	- Dockerfile: Config to define & create an image
		- FROM: Base Image
		- RUN: Execute command
		- WORKDIR: Change working dir
		- COPY: Copy files/dir form host to image
		- ENV: Defines variables
		- EXPOSE: Open port
		- CMD: Specify commands to execute container
		- ENTRYPOINT: The command to execute container 
		- LABEL: KV Metadata 

## 3. Kubernetes Basics
## 4. Introduction to OKE
## 5. OKE Cluster Access
## 6. OKE Virtual Nodes
## 7. Self-Manage Nodes
## 8. Managing K8S Deployments
### 9. Setting Up Storage for OKE Clusters
## 10. Administering OKE Clusters
## 11. Container Engine for K8S Security
## 12. Project Basic
## 13. Project CI/CD
## 14. Deployment Strategies
## 15. Helm Chart Deployments 
## 16. Terraform IaC
## 17. OCI Resource Manager IaC
## 18. DevSecOps
## 19. Observability





