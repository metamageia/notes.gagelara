A network within a network for efficiently routing traffic. Defined by a range of consecutive IP addresses in a network, and can be used to limit access to other parts of the network.

Traffic moving within a defined subnet does not need to pass through a router, allowing data to transfer more quickly and reducing router bandwidth. 

Subnet must have a [[Classless Inter-Domain Routing (CIDR)|CIDR block]], and cannot overlap with existing subnet IP addresses. 

```
Example
Subnet A: 10.0.0.0/26 (Would provide 10.0.0.0 - 10.0.0.63)
Subnet B: 10.0.0.64/26 (Would provide 10.0.0.64 - 10.0.0.127)
```

Public Subnets allow internet traffic routed through an internet gateway. 

Private Subnets denies traffic routed from the internet, and requires a NAT devices to access the public internet. 

