


Requires Talos CTL to access.
- `talosctl gen secrets` 
- `talosctl gen config` 
	- Cluster Name 
	- K8S Endpoint: Point to DNS Name or IP Address of load balancer (or single node)
		- Talos allows for creating a Virtual IP to load balance nodes
```
Example:
export TALOS_ENDPOINT=<DROPLET_PUBLIC_IP>
export CLUSTER_NAME=mytaloscluster

talosctl gen config ${CLUSTER_NAME} https://${TALOS_ENDPOINT}:6443
```

> Note: If not using a loadbalancer or dns name use a reserved ip. Create the nodes, passing the user_data .yaml configurations appropriate for each node

- `talosctl --talosconfig ./talosconfig config endpoint ${TALOS_ENDPOINT}` 
- `talosctl --talosconfig ./talosconfig config node ${TALOS_ENDPOINT}` 
- `talosctl --talosconfig ./talosconfig bootstrap`
- `talosctl --talosconfig talosconfig kubeconfig .`
- `talosctl --talosconfig talosconfig health`

Using kubectl with talos
- kubectl --kubeconfig kubeconfig get nodes