# Virtual Public Cloud

I recommend the [AWS VPC Beginner to Pro - Virtual Private Cloud Tutorial](https://www.youtube.com/watch?v=g2JOHLHh4rI) if you wish to learn learn more.

In this section, I'll summarise some key concepts drawn from my recommended tutorial.

## Structure of IPv4 Address

An IPv4 in a dotted decimal notation, an example is shown below:

```
192.168.0.1
```

Each of the four decimal part of representing a binary octet -- 0 to 255. 

The first three decimal blocks refers to the Network ID. The last decimal block is the Host ID.


Subnet mask is used to separate a network address from the host id in an IP address. For example:

```
IP Address    192.168.0.0
Subnet Mask   255.255.255.0

Reveal a network ID 192.168.0.0/24 <- This format is typically used in AWS VPC
```

There are several classes of IPv4 address

### Class A network

This looks like this: 
```
10.0.0.0
255.0.0.0
```

* First assignable is 10.0.0.1
* Last assignable is 10.255.255.254 (10.255.255.255 is a broadcast address)
* Total networks = 126
* Usable address per network == 65,534

### Class B network

This looks like:
```
172.16.0.0
255.255.0.0
```
* First assignable is 172.16.0.1
* Last assignable is 172.16.255.254
* Total networks = 16,382
* Usable address per network = 65,534

### Class C network

This looks like:
```
192.168.0.0
255.255.255.0
```
* First assignable is 192.169.0.1
* Last assignable is 192.168.0.254
* Total networks = 2,097,150
* Usable address per network = 254

### Private IP Address range

```
10.0.0.0 to 10.255.255.255
172.16.0.0 to 172.32.255.255
192.168.0.0 to 192.168.0.255
```

Reserve for use in private network according to [IETF RFC-1918](https://datatracker.ietf.org/doc/html/rfc1918) and can't be used in the public internet

### Classless Interdomain Routing (CIDR)

Example:

```
Network         192.168.0.0
/24 Subnet mask 255.255.255.0 <- 8 bits host ID == 254 addresses
/16 Subnet mask 255.255.0.0   <- 16 bits host ID = 65,534 addresses
/20 Subnet mask 255.255.(0).0 <- borrow from 2nd last block (4bit) so 12 bits hosts ID = 4094 addresses (192.168.0.1 - 192.168.15.254)
```

The /20 is an example of a CIDR using variable lenght subnet masks.