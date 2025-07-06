A method for defining an IP range, a CIDR block include the IP Address (network identifier) followed by a Netmask represented by a trailing `/` and a number, which defines how many bits of the routing prefix (IP) must be fixed for the identifier. 

```
Example:
192.0.2.0/24

The first 24 bits must remain fixed, but the final 8 bits - the last digit - can be incremented to provide a unique host identifier. In this case a /24 netmask provides 256 unique IP Addresses in the network.
```

Two special cases:
- Fixed addresses with a /32 netmask to give access to a specific host
- Internet CIDR block with a /0 netmask allows internet traffic 
Neither can be used as a network CIDR block, but can be used in firewall rules for controlling access. 