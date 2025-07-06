Amazon's [[Virtual Private Cloud (VPC)]] service, a logically isolated VPC connected to an AWS account with direct access to other AWS services and define connectivity between server. 

VPCs are Region specific, [[Subnet]]s can be launched in separate availability zones with custom security configurations.

AWS VPCs have no additional charges, and instead only charge for specific features like NAT gateway or deployed resources. AWS Accounts automatically come with a default VPC, which itself comes with a public subnet with internet access for every availability zone in the region. Best practice suggests users don't modify or delete their default VPC, but create custom VPCs for specific needs - max 5per region (but more can be requested.)

> Use Case:
> Multi-tier webapp with three tiers:
> - Presentation tier, such as a website
> - Logic tier, such as the backend app server in a private subnet 
> - Data tier, the database typically in a private subnet that only connects to the logic tier

Private subnets can be accessed externally via a [[Virtual Private Network (VPN)]]

VPC Patterns:
- Single VPC: Small, single applications / High-performance Compute / Identity management
- Multi-VPC: Single teams/orgs
- Multi-account VPCs: Large organizations with multiple teams to distribute access management and standards.

VPC ID: Random string used to identify the VPC
VPC tags: A human readable name for identifying VPCs and components 

Internet Gateway is a horizontally scaled and redundant VPC component that connects to the internet. Each VPC can only have one. 

Network Gateways allow direct on-premises site connections to the VPC via VPN. 

Route Tables define traffic access between IPs. Example, a table with destination 0.0.0.0/0 and target igw-12345 (Internet Gateway) will connect the gateway to the internet, which can then be routed to specific subnets. Subnets must be associated with only one route table, but each table can list many subnets. 

---

Security groups serve as a firewall for specific resource instances, such as EC2s with their own allow rules for inbound and outbound traffic.
- By default no inbound traffic is allowed. 
- By default, all outbound traffic is allowed. 
Security groups are stateful, meaning every inbound rule allows an outbound response and vice versa. The security group rules specifically determine who gets to initiate a request. 

EC2 and RDS instances requires a security group.  Same group can be used on any instance within the subnet it was created in. 


---

Network ACL are Subnet level firewalls. Every subnet must have an ACL, and will use the default ACL if one isn't defined. Each subnet can only have one ACL, but the same ACL can be used across multiple subnets. They are stateless, so unlike security groups all inbound and outbound rules must be defined explicitly. 

Network ACLs can have allow or deny rules, and can be used to keep traffic from either entering or leaving selectively. Firewall rules are evaluated starting with the lowest rule to the highest, with the lowest taking priority. 

The default ACL allows all inbound and outbound traffic, while a custom network ACL defaults to deny all traffic. 

---

- Elastic IP Address: In a VPC every instance has a private IP, and a generated public IP can be requested. Elastic IPs are static IPv4 addresses and can be assigned to specific instances. Elastic IPs can mask an instance failure by dynamically reassigning to a different instance or maintain accessibility following processes that would normally cause the IP to change such as stopping or resetting the instance.
	- They operate at the instance level, and only generate costs *when not in use*
- NAT Gateways allow instances in a private subnet to connect to the internet or other AWS services
- AWS VPN requires a Virtual Private Gateway to allow access to the VPC, configure a Customer Gateway, then create a private route table & security rules, and finally site-to-site VPN connection. 
- AWS Direct Connect can improve performance by keeping traffic on the AWS Cloud Network without touching the internet. 
- VPC Endponts
	- Interface VPC Endpoints: AWS PrivateLink allows private connectivity between VPCS, AWS Services an on-prem networks without exposing traffic to the internet. 
	- Gateway Endpoints specifically allow a VPC to conenct to S3 and DynamoDB without connecting to the internet. 
- VPC Peering Connection: Allows VPCs to communicate as if they were on the same network, so long as the CIDR Blocks don't overlap. Peers must also be explicit, peer connections cannot be chained. 
- AWS Transit Gateway: A hub for routing multiple networks (VPCs, VPNs, DirectConnect, etc) using a single resource - simplifying network architecture 