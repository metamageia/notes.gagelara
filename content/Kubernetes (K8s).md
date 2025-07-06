---
aliases:
  - Kubernetes
  - K8s
---
Is a FOSS container orchestration platform for automating the deployment, management, and scaling of containers at scale using [[Declarative Configuration]]. As opposed to [[Docker]] - which is used to build, ship, and run individual containers on a specific machine - K8s is used to manage many containers across multiple machines in a production environment. 

In a directory with Kubernetes configuration files, the command `sudo kubectl apply -f <file>` can be used to apply the configuration

- Cluster contains Control Plane (Master node) and worker nodes (running kubelets and containers).
	- Control Plane 
		- API server in container
		- Control Manager Container
		- Scheduler Container ensures pod placement
		- etcd backing store tracks and backs up cluster state
	- Virtual Network combines cluster into single machine
- Components
	- Node
		- Pod = Smallest  Unit. Abstraction over single container. Each pod gets internal IP Address. Pods are ephemeral.
		- Service = Permaent IP Address attacked to pods with its own lifecycle, allowing access to ephemeral pods. External Services for browser access IP, Internal Services for in-cluster access
			- Also a load balancer for ephemeral pods
		- Ingress = Forwards traffic to External Service with human readable name
		- Config Map = External Configuration of application, like URLS to attach to ephemeral pods
		- Secret = Identical to Config, but to be encrypted for secrets, to be connected to application pods
		- Volume = Attaches either local or remote storage to pod. External to the cluster, not managed by K8S
		- Deployment = Blueprint for pods that K8S uses to spin up ephemeral pods. Abstraction on top of pods. 
			- Stateful applications like DBs can't be deployments
		- StatfulSet = Like deployments for stateful apps like DBs, keeping them synchronized, though it's common practice to externalize stateful apps rather than using K8S
	- Control Plane
		- API Server = Handles UI, API YAMLScripting, or CLI like Kubectl. Declarative configuration.
			- Configs: Metadata for kind/version. Specifications include data about the kind. Status is automatically generated - the actual status as opposed to the declared specifications. 
		- etcd = Holds the current status of all cluster components


- Minikube = One node cluster setup for testing or simple infra
	- `minikube start --driver docker` 
- Kind = Multi-node cluster deployed in docker containers acting as nodes, recommended for learning. 
- [[K3s]] = Lightweight for local, cloud, IoT, etc
- Kubectl = command line tool for accessing API Server

---

Architecture
- Worker Node
	- Container Runtime - Docker/etc
	- Kubelet - Scheduler. Takes the config and starts pods with containers. Connects to container runtimes through the Container Runtime Interface (CRI).
		- CRI Shims are CRI implementations specific to each container runtime. 
	- KubeProxy - Handles communications between nodes, services and other components. It handles dynamic updates and maintenance of all networking rules on the node in conjunction with the iptables utility. 
- Master Node
	- API Server validates request then forwards to nodes
	- Scheduler decides which nodes to deploy pods on
	- Controller Manager monitors for pod failures and signals scheduler to reboot
	- etc manages cluster state information
- Networking
	- Container-to-Container: Containers operate in an isolated network, referred to as network namespace. This namespace can be shared with other containers, or with the host. Grouped containers in a Pod communicate via localhost using an automatically initialized container dedicated to creating a shared network namespace. 
	- Pod-to-Pod: All pods in a cluster are expected to be able to communicate without NAT. K8S uses an "IP-per-Pod" model, giving each pod a network interface. 
	- External-to-Pod: Services expose Pods to incoming/outgoing traffic from the cluster, allowing external access. 

---

Deployment and Service often together

Deployments
- Spec: Deployment specific config
	- Templates defines Pod Config
		- Spec: Config of the container(s) in pod
		-  `env:` Allows for the passing of env variables in configuration
- Labels allow you to identify pod replicas of the same resource
	- Required for pods, but option for other components
	- Controllers/Operators and services use label selectors to select objects.
		- Equality Based allow filtering based on label keys and values.
		- Set Based selectors allow filtering based on a set of values rather than single key=value pairs. 
- Selector matches pods to deployment based on label key:value pairs (app: key is best practice)
	- Service selector label should match pods label, which it uses to access pods. 


```
Example: Using Secrets in ENV Variables

env:
  - name: MONGO_INITDB_ROOT_USERNAME
    valueFrom:
      secretKeyRef:
        name: mongo-secret
        key: mongo-user
```

- `nodePort` IP value on a service which allows a service to be accessed externally 
	- Must be between 30000 - 32767

- `kubectl apply -f ./pathtofile` To create components
- `kubectl get pods` or configmap or secrets etc
- `minikube ip` or `kubegtl get svc -o wide`

---

- PersistentVolume (PV): is a piece of storage that has been provisioned manually or dynamically using Storage Classes. It's a resource in the cluster and are volume plugins like Volumes, but their lifecycle is independent of any Pod. 
- A PersistentVolumeClaim (PVC) is a request for storage by a user. Similar to a Pod that consumes node resources, PVCs consume PV resources. Claims request specific size and access modes to a PV.
- PVs are volume resources, PVCs are requests for those resources. 

K8S Architectures
- Single Node: Mostly for learning, everything runs on a single node.
- Single Control Plane & Multi Worker
- Single Control Plane, Single etcd, and Multi Worker: Externalized etcd
- Multi Control Plane and Multi Worker: configured for High-Availability (HA), with each control lane running a stacked etcd instance. 
- Multi Control Plane, Multi etcd, Multi Worker: Several externalized etcd in an HA cluster - considered the most advanced cluster configuration and recommended for production environments. 

---

APIs with Authentication
- A Bearer Token is an access token that can be generated by the authentication serve
- Role Based Access Control (RBAC)

---

Namespaces
- A virtual sub-cluster to partition resources
- Four default namespaces
	- Default contains the objects and resources created
	- kube-nodelease holds lease objects for node heartbeat data
	- kube-public is an unsecured namespace for exposing public info about the cluster
	- kube-system contins objects created automatically by the K8S system, namely control plane agents

---

- ReplicatonController: No longer recomended, it's a complex operator that ensures a specified number of replicas are running at a given time. The default recomended controller is the Deployment, which configures a ReplicaSet controller to manage lifecycle 
- ReplicaSet: Supports replication and self-healing of pods, both equality and set selectors. 
	- Deployments automatically create replica sets, so they don't need to be created separately
---

- DaemonSets are operators designed to manage node agents. They are different than RS and Deployments in that DaemonSets enforces a single Pod replica per node, on all nodes, or on a subset. 
	- When a node is added to the cluster, the DS's pods are automatically placed on it.

---

[[OCI Container]]
[[K3s]] 