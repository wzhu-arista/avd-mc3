# FABRIC

## Table of Contents

- [Fabric Switches and Management IP](#fabric-switches-and-management-ip)
  - [Fabric Switches with inband Management IP](#fabric-switches-with-inband-management-ip)
- [Fabric Topology](#fabric-topology)
- [Fabric IP Allocation](#fabric-ip-allocation)
  - [Fabric Point-To-Point Links](#fabric-point-to-point-links)
  - [Point-To-Point Links Node Allocation](#point-to-point-links-node-allocation)
  - [Loopback Interfaces (BGP EVPN Peering)](#loopback-interfaces-bgp-evpn-peering)
  - [Loopback0 Interfaces Node Allocation](#loopback0-interfaces-node-allocation)
  - [VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)](#vtep-loopback-vxlan-tunnel-source-interfaces-vteps-only)
  - [VTEP Loopback Node allocation](#vtep-loopback-node-allocation)

## Fabric Switches and Management IP

| POD | Type | Node | Management IP | Platform | Provisioned in CloudVision | Serial Number |
| --- | ---- | ---- | ------------- | -------- | -------------------------- | ------------- |
| FABRIC | l3leaf | dc1-bl1 | 192.168.124.109/24 | vEOS-lab | Provisioned | - |
| FABRIC | l3leaf | dc1-bl2 | 192.168.124.110/24 | vEOS-lab | Provisioned | - |
| FABRIC | l3leaf | dc1-leaf1 | 192.168.124.103/24 | vEOS-lab | Provisioned | - |
| FABRIC | l3leaf | dc1-leaf2a | 192.168.124.105/24 | vEOS-lab | Provisioned | - |
| FABRIC | l3leaf | dc1-leaf2b | 192.168.124.106/24 | vEOS-lab | Provisioned | - |
| FABRIC | l2leaf | dc1-leaf2c | 192.168.124.107/24 | vEOS-lab | Provisioned | - |
| FABRIC | spine | dc1-spine1 | 192.168.124.101/24 | vEOS-lab | Provisioned | - |
| FABRIC | spine | dc1-spine2 | 192.168.124.102/24 | vEOS-lab | Provisioned | - |
| FABRIC | l3leaf | dc2-bl1 | 192.168.124.119/24 | vEOS-lab | Provisioned | - |
| FABRIC | l3leaf | dc2-bl2 | 192.168.124.120/24 | vEOS-lab | Provisioned | - |
| FABRIC | l3leaf | dc2-leaf1 | 192.168.124.113/24 | vEOS-lab | Provisioned | - |
| FABRIC | l3leaf | dc2-leaf2a | 192.168.124.115/24 | vEOS-lab | Provisioned | - |
| FABRIC | l3leaf | dc2-leaf2b | 192.168.124.116/24 | vEOS-lab | Provisioned | - |
| FABRIC | l2leaf | dc2-leaf2c | 192.168.124.107/24 | vEOS-lab | Provisioned | - |
| FABRIC | spine | dc2-spine1 | 192.168.124.111/24 | vEOS-lab | Provisioned | - |
| FABRIC | spine | dc2-spine2 | 192.168.124.112/24 | vEOS-lab | Provisioned | - |

> Provision status is based on Ansible inventory declaration and do not represent real status from CloudVision.

### Fabric Switches with inband Management IP

| POD | Type | Node | Management IP | Inband Interface |
| --- | ---- | ---- | ------------- | ---------------- |

## Fabric Topology

| Type | Node | Node Interface | Peer Type | Peer Node | Peer Interface |
| ---- | ---- | -------------- | --------- | ----------| -------------- |
| l3leaf | dc1-bl1 | Ethernet1 | spine | dc1-spine1 | Ethernet4 |
| l3leaf | dc1-bl1 | Ethernet2 | spine | dc1-spine2 | Ethernet4 |
| l3leaf | dc1-bl1 | Ethernet4 | l3leaf | dc2-bl1 | Ethernet4 |
| l3leaf | dc1-bl2 | Ethernet1 | spine | dc1-spine1 | Ethernet5 |
| l3leaf | dc1-bl2 | Ethernet2 | spine | dc1-spine2 | Ethernet5 |
| l3leaf | dc1-bl2 | Ethernet4 | l3leaf | dc2-bl2 | Ethernet4 |
| l3leaf | dc1-leaf1 | Ethernet1 | spine | dc1-spine1 | Ethernet1 |
| l3leaf | dc1-leaf1 | Ethernet2 | spine | dc1-spine2 | Ethernet1 |
| l3leaf | dc1-leaf2a | Ethernet1 | spine | dc1-spine1 | Ethernet2 |
| l3leaf | dc1-leaf2a | Ethernet2 | spine | dc1-spine2 | Ethernet2 |
| l3leaf | dc1-leaf2a | Ethernet3 | mlag_peer | dc1-leaf2b | Ethernet3 |
| l3leaf | dc1-leaf2a | Ethernet4 | l2leaf | dc1-leaf2c | Ethernet1 |
| l3leaf | dc1-leaf2b | Ethernet1 | spine | dc1-spine1 | Ethernet3 |
| l3leaf | dc1-leaf2b | Ethernet2 | spine | dc1-spine2 | Ethernet3 |
| l3leaf | dc1-leaf2b | Ethernet4 | l2leaf | dc1-leaf2c | Ethernet2 |
| l3leaf | dc2-bl1 | Ethernet1 | spine | dc2-spine1 | Ethernet4 |
| l3leaf | dc2-bl1 | Ethernet2 | spine | dc2-spine2 | Ethernet4 |
| l3leaf | dc2-bl2 | Ethernet1 | spine | dc2-spine1 | Ethernet5 |
| l3leaf | dc2-bl2 | Ethernet2 | spine | dc2-spine2 | Ethernet5 |
| l3leaf | dc2-leaf1 | Ethernet1 | spine | dc2-spine1 | Ethernet1 |
| l3leaf | dc2-leaf1 | Ethernet2 | spine | dc2-spine2 | Ethernet1 |
| l3leaf | dc2-leaf2a | Ethernet1 | spine | dc2-spine1 | Ethernet2 |
| l3leaf | dc2-leaf2a | Ethernet2 | spine | dc2-spine2 | Ethernet2 |
| l3leaf | dc2-leaf2a | Ethernet3 | mlag_peer | dc2-leaf2b | Ethernet3 |
| l3leaf | dc2-leaf2a | Ethernet4 | l2leaf | dc2-leaf2c | Ethernet1 |
| l3leaf | dc2-leaf2b | Ethernet1 | spine | dc2-spine1 | Ethernet3 |
| l3leaf | dc2-leaf2b | Ethernet2 | spine | dc2-spine2 | Ethernet3 |
| l3leaf | dc2-leaf2b | Ethernet4 | l2leaf | dc2-leaf2c | Ethernet2 |

## Fabric IP Allocation

### Fabric Point-To-Point Links

| Uplink IPv4 Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ---------------- | ------------------- | ------------------ | ------------------ |
| 10.255.1.32/27 | 32 | 20 | 62.5 % |
| 10.255.2.32/27 | 32 | 20 | 62.5 % |

### Point-To-Point Links Node Allocation

| Node | Node Interface | Node IP Address | Peer Node | Peer Interface | Peer IP Address |
| ---- | -------------- | --------------- | --------- | -------------- | --------------- |
| dc1-bl1 | Ethernet1 | 10.255.1.45/31 | dc1-spine1 | Ethernet4 | 10.255.1.44/31 |
| dc1-bl1 | Ethernet2 | 10.255.1.47/31 | dc1-spine2 | Ethernet4 | 10.255.1.46/31 |
| dc1-bl1 | Ethernet4 | 172.100.100.0/31 | dc2-bl1 | Ethernet4 | 172.100.100.1/31 |
| dc1-bl2 | Ethernet1 | 10.255.1.49/31 | dc1-spine1 | Ethernet5 | 10.255.1.48/31 |
| dc1-bl2 | Ethernet2 | 10.255.1.51/31 | dc1-spine2 | Ethernet5 | 10.255.1.50/31 |
| dc1-bl2 | Ethernet4 | 172.100.100.2/31 | dc2-bl2 | Ethernet4 | 172.100.100.3/31 |
| dc1-leaf1 | Ethernet1 | 10.255.1.33/31 | dc1-spine1 | Ethernet1 | 10.255.1.32/31 |
| dc1-leaf1 | Ethernet2 | 10.255.1.35/31 | dc1-spine2 | Ethernet1 | 10.255.1.34/31 |
| dc1-leaf2a | Ethernet1 | 10.255.1.37/31 | dc1-spine1 | Ethernet2 | 10.255.1.36/31 |
| dc1-leaf2a | Ethernet2 | 10.255.1.39/31 | dc1-spine2 | Ethernet2 | 10.255.1.38/31 |
| dc1-leaf2b | Ethernet1 | 10.255.1.41/31 | dc1-spine1 | Ethernet3 | 10.255.1.40/31 |
| dc1-leaf2b | Ethernet2 | 10.255.1.43/31 | dc1-spine2 | Ethernet3 | 10.255.1.42/31 |
| dc2-bl1 | Ethernet1 | 10.255.2.45/31 | dc2-spine1 | Ethernet4 | 10.255.2.44/31 |
| dc2-bl1 | Ethernet2 | 10.255.2.47/31 | dc2-spine2 | Ethernet4 | 10.255.2.46/31 |
| dc2-bl2 | Ethernet1 | 10.255.2.49/31 | dc2-spine1 | Ethernet5 | 10.255.2.48/31 |
| dc2-bl2 | Ethernet2 | 10.255.2.51/31 | dc2-spine2 | Ethernet5 | 10.255.2.50/31 |
| dc2-leaf1 | Ethernet1 | 10.255.2.33/31 | dc2-spine1 | Ethernet1 | 10.255.2.32/31 |
| dc2-leaf1 | Ethernet2 | 10.255.2.35/31 | dc2-spine2 | Ethernet1 | 10.255.2.34/31 |
| dc2-leaf2a | Ethernet1 | 10.255.2.37/31 | dc2-spine1 | Ethernet2 | 10.255.2.36/31 |
| dc2-leaf2a | Ethernet2 | 10.255.2.39/31 | dc2-spine2 | Ethernet2 | 10.255.2.38/31 |
| dc2-leaf2b | Ethernet1 | 10.255.2.41/31 | dc2-spine1 | Ethernet3 | 10.255.2.40/31 |
| dc2-leaf2b | Ethernet2 | 10.255.2.43/31 | dc2-spine2 | Ethernet3 | 10.255.2.42/31 |

### Loopback Interfaces (BGP EVPN Peering)

| Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ------------- | ------------------- | ------------------ | ------------------ |
| 10.255.1.0/27 | 32 | 12 | 37.5 % |
| 10.255.1.0/28 | 16 | 7 | 43.75 % |
| 10.255.2.0/27 | 32 | 12 | 37.5 % |
| 10.255.2.0/28 | 16 | 7 | 43.75 % |

### Loopback0 Interfaces Node Allocation

| POD | Node | Loopback0 |
| --- | ---- | --------- |
| FABRIC | dc1-bl1 | 10.255.1.6/32 |
| FABRIC | dc1-bl2 | 10.255.1.7/32 |
| FABRIC | dc1-leaf1 | 10.255.1.3/32 |
| FABRIC | dc1-leaf2a | 10.255.1.4/32 |
| FABRIC | dc1-leaf2b | 10.255.1.5/32 |
| FABRIC | dc1-spine1 | 10.255.1.1/32 |
| FABRIC | dc1-spine2 | 10.255.1.2/32 |
| FABRIC | dc2-bl1 | 10.255.2.6/32 |
| FABRIC | dc2-bl2 | 10.255.2.7/32 |
| FABRIC | dc2-leaf1 | 10.255.2.3/32 |
| FABRIC | dc2-leaf2a | 10.255.2.4/32 |
| FABRIC | dc2-leaf2b | 10.255.2.5/32 |
| FABRIC | dc2-spine1 | 10.255.2.1/32 |
| FABRIC | dc2-spine2 | 10.255.2.2/32 |

### VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)

| VTEP Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| --------------------- | ------------------- | ------------------ | ------------------ |
| 10.255.1.16/28 | 16 | 5 | 31.25 % |
| 10.255.2.16/28 | 16 | 5 | 31.25 % |

### VTEP Loopback Node allocation

| POD | Node | Loopback1 |
| --- | ---- | --------- |
| FABRIC | dc1-bl1 | 10.255.1.22/32 |
| FABRIC | dc1-bl2 | 10.255.1.23/32 |
| FABRIC | dc1-leaf1 | 10.255.1.19/32 |
| FABRIC | dc1-leaf2a | 10.255.1.20/32 |
| FABRIC | dc1-leaf2b | 10.255.1.20/32 |
| FABRIC | dc2-bl1 | 10.255.2.22/32 |
| FABRIC | dc2-bl2 | 10.255.2.23/32 |
| FABRIC | dc2-leaf1 | 10.255.2.19/32 |
| FABRIC | dc2-leaf2a | 10.255.2.20/32 |
| FABRIC | dc2-leaf2b | 10.255.2.20/32 |
