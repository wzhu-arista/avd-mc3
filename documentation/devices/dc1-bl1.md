# dc1-bl1

## Table of Contents

- [Management](#management)
  - [Management Interfaces](#management-interfaces)
  - [Management API HTTP](#management-api-http)
- [Authentication](#authentication)
  - [Local Users](#local-users)
  - [AAA Authorization](#aaa-authorization)
- [LACP](#lacp)
  - [LACP Summary](#lacp-summary)
  - [LACP Device Configuration](#lacp-device-configuration)
- [Spanning Tree](#spanning-tree)
  - [Spanning Tree Summary](#spanning-tree-summary)
  - [Spanning Tree Device Configuration](#spanning-tree-device-configuration)
- [Internal VLAN Allocation Policy](#internal-vlan-allocation-policy)
  - [Internal VLAN Allocation Policy Summary](#internal-vlan-allocation-policy-summary)
  - [Internal VLAN Allocation Policy Device Configuration](#internal-vlan-allocation-policy-device-configuration)
- [VLANs](#vlans)
  - [VLANs Summary](#vlans-summary)
  - [VLANs Device Configuration](#vlans-device-configuration)
- [Interfaces](#interfaces)
  - [Ethernet Interfaces](#ethernet-interfaces)
  - [Loopback Interfaces](#loopback-interfaces)
  - [VLAN Interfaces](#vlan-interfaces)
  - [VXLAN Interface](#vxlan-interface)
- [Routing](#routing)
  - [Service Routing Protocols Model](#service-routing-protocols-model)
  - [Virtual Router MAC Address](#virtual-router-mac-address)
  - [IP Routing](#ip-routing)
  - [IPv6 Routing](#ipv6-routing)
  - [Static Routes](#static-routes)
  - [Router BGP](#router-bgp)
- [BFD](#bfd)
  - [Router BFD](#router-bfd)
- [Multicast](#multicast)
  - [IP IGMP Snooping](#ip-igmp-snooping)
  - [Router Multicast](#router-multicast)
  - [PIM Sparse Mode](#pim-sparse-mode)
- [Filters](#filters)
  - [Prefix-lists](#prefix-lists)
  - [Route-maps](#route-maps)
- [VRF Instances](#vrf-instances)
  - [VRF Instances Summary](#vrf-instances-summary)
  - [VRF Instances Device Configuration](#vrf-instances-device-configuration)
- [Virtual Source NAT](#virtual-source-nat)
  - [Virtual Source NAT Summary](#virtual-source-nat-summary)
  - [Virtual Source NAT Configuration](#virtual-source-nat-configuration)

## Management

### Management Interfaces

#### Management Interfaces Summary

##### IPv4

| Management Interface | description | Type | VRF | IP Address | Gateway |
| -------------------- | ----------- | ---- | --- | ---------- | ------- |
| Management0 | oob_management | oob | MGMT | 192.168.124.109/24 | 192.168.124.1 |

##### IPv6

| Management Interface | description | Type | VRF | IPv6 Address | IPv6 Gateway |
| -------------------- | ----------- | ---- | --- | ------------ | ------------ |
| Management0 | oob_management | oob | MGMT | - | - |

#### Management Interfaces Device Configuration

```eos
!
interface Management0
   description oob_management
   no shutdown
   vrf MGMT
   ip address 192.168.124.109/24
```

### Management API HTTP

#### Management API HTTP Summary

| HTTP | HTTPS | Default Services |
| ---- | ----- | ---------------- |
| False | True | - |

#### Management API VRF Access

| VRF Name | IPv4 ACL | IPv6 ACL |
| -------- | -------- | -------- |
| MGMT | - | - |

#### Management API HTTP Device Configuration

```eos
!
management api http-commands
   protocol https
   no shutdown
   !
   vrf MGMT
      no shutdown
```

## Authentication

### Local Users

#### Local Users Summary

| User | Privilege | Role | Disabled | Shell |
| ---- | --------- | ---- | -------- | ----- |
| admin | 15 | network-admin | False | - |
| ansible | 15 | network-admin | False | - |

#### Local Users Device Configuration

```eos
!
username admin privilege 15 role network-admin secret sha512 <removed>
username ansible privilege 15 role network-admin secret sha512 <removed>
```

### AAA Authorization

#### AAA Authorization Summary

| Type | User Stores |
| ---- | ----------- |
| Exec | local |

Authorization for configuration commands is disabled.

#### AAA Authorization Device Configuration

```eos
aaa authorization exec default local
!
```

## LACP

### LACP Summary

| Port-id range | Rate-limit default | System-priority |
| ------------- | ------------------ | --------------- |
| 129 - 256 | - | - |

### LACP Device Configuration

```eos
!
lacp port-id range 129 256
```

## Spanning Tree

### Spanning Tree Summary

STP mode: **mstp**

#### MSTP Instance and Priority

| Instance(s) | Priority |
| -------- | -------- |
| 0 | 4096 |

### Spanning Tree Device Configuration

```eos
!
spanning-tree mode mstp
spanning-tree mst 0 priority 4096
```

## Internal VLAN Allocation Policy

### Internal VLAN Allocation Policy Summary

| Policy Allocation | Range Beginning | Range Ending |
| ------------------| --------------- | ------------ |
| ascending | 1006 | 1199 |

### Internal VLAN Allocation Policy Device Configuration

```eos
!
vlan internal order ascending range 1006 1199
```

## VLANs

### VLANs Summary

| VLAN ID | Name | Trunk Groups |
| ------- | ---- | ------------ |
| 101 | VRF100_VLAN101 | - |
| 102 | VRF100_VLAN102 | - |

### VLANs Device Configuration

```eos
!
vlan 101
   name VRF100_VLAN101
!
vlan 102
   name VRF100_VLAN102
```

## Interfaces

### Ethernet Interfaces

#### Ethernet Interfaces Summary

##### L2

| Interface | Description | Mode | VLANs | Native VLAN | Trunk Group | Channel-Group |
| --------- | ----------- | ---- | ----- | ----------- | ----------- | ------------- |

*Inherited from Port-Channel Interface

##### Encapsulation Dot1q Interfaces

| Interface | Description | Type | Vlan ID | Dot1q VLAN Tag |
| --------- | ----------- | -----| ------- | -------------- |
| Ethernet4.121 | To-DC2-BL1-VRF200 | l3dot1q | - | 121 |

##### IPv4

| Interface | Description | Type | Channel Group | IP Address | VRF |  MTU | Shutdown | ACL In | ACL Out |
| --------- | ----------- | -----| ------------- | ---------- | ----| ---- | -------- | ------ | ------- |
| Ethernet1 | P2P_LINK_TO_DC1-SPINE1_Ethernet4 | routed | - | 10.255.1.45/31 | default | 1500 | False | - | - |
| Ethernet2 | P2P_LINK_TO_DC1-SPINE2_Ethernet4 | routed | - | 10.255.1.47/31 | default | 1500 | False | - | - |
| Ethernet4 | P2P_LINK_TO_dc2-bl1_Ethernet4 | routed | - | 172.100.100.0/31 | default | 1500 | False | - | - |
| Ethernet4.121 | To-DC2-BL1-VRF200 | l3dot1q | - | 10.0.0.0/31 | VRF100 | 1500 | False | - | - |

#### Ethernet Interfaces Device Configuration

```eos
!
interface Ethernet1
   description P2P_LINK_TO_DC1-SPINE1_Ethernet4
   no shutdown
   mtu 1500
   no switchport
   ip address 10.255.1.45/31
   pim ipv4 sparse-mode
!
interface Ethernet2
   description P2P_LINK_TO_DC1-SPINE2_Ethernet4
   no shutdown
   mtu 1500
   no switchport
   ip address 10.255.1.47/31
   pim ipv4 sparse-mode
!
interface Ethernet4
   description P2P_LINK_TO_dc2-bl1_Ethernet4
   no shutdown
   mtu 1500
   no switchport
   ip address 172.100.100.0/31
!
interface Ethernet4.121
   description To-DC2-BL1-VRF200
   no shutdown
   mtu 1500
   encapsulation dot1q vlan 121
   vrf VRF100
   ip address 10.0.0.0/31
   pim ipv4 sparse-mode
```

### Loopback Interfaces

#### Loopback Interfaces Summary

##### IPv4

| Interface | Description | VRF | IP Address |
| --------- | ----------- | --- | ---------- |
| Loopback0 | EVPN_Overlay_Peering | default | 10.255.1.6/32 |
| Loopback1 | VTEP_VXLAN_Tunnel_Source | default | 10.255.1.22/32 |
| Loopback100 | VRF100_VTEP_DIAGNOSTICS | VRF100 | 10.255.100.6/32 |

##### IPv6

| Interface | Description | VRF | IPv6 Address |
| --------- | ----------- | --- | ------------ |
| Loopback0 | EVPN_Overlay_Peering | default | - |
| Loopback1 | VTEP_VXLAN_Tunnel_Source | default | - |
| Loopback100 | VRF100_VTEP_DIAGNOSTICS | VRF100 | - |

#### Loopback Interfaces Device Configuration

```eos
!
interface Loopback0
   description EVPN_Overlay_Peering
   no shutdown
   ip address 10.255.1.6/32
!
interface Loopback1
   description VTEP_VXLAN_Tunnel_Source
   no shutdown
   ip address 10.255.1.22/32
!
interface Loopback100
   description VRF100_VTEP_DIAGNOSTICS
   no shutdown
   vrf VRF100
   ip address 10.255.100.6/32
```

### VLAN Interfaces

#### VLAN Interfaces Summary

| Interface | Description | VRF |  MTU | Shutdown |
| --------- | ----------- | --- | ---- | -------- |
| Vlan101 | VRF100_VLAN101 | VRF100 | - | False |
| Vlan102 | VRF100_VLAN102 | VRF100 | - | False |

##### IPv4

| Interface | VRF | IP Address | IP Address Virtual | IP Router Virtual Address | VRRP | ACL In | ACL Out |
| --------- | --- | ---------- | ------------------ | ------------------------- | ---- | ------ | ------- |
| Vlan101 |  VRF100  |  -  |  10.10.101.1/24  |  -  |  -  |  -  |  -  |
| Vlan102 |  VRF100  |  -  |  10.10.102.1/24  |  -  |  -  |  -  |  -  |

#### VLAN Interfaces Device Configuration

```eos
!
interface Vlan101
   description VRF100_VLAN101
   no shutdown
   vrf VRF100
   ip igmp
   pim ipv4 local-interface Loopback100
   ip address virtual 10.10.101.1/24
!
interface Vlan102
   description VRF100_VLAN102
   no shutdown
   vrf VRF100
   ip igmp
   pim ipv4 local-interface Loopback100
   ip address virtual 10.10.102.1/24
```

### VXLAN Interface

#### VXLAN Interface Summary

| Setting | Value |
| ------- | ----- |
| Source Interface | Loopback1 |
| UDP port | 4789 |

##### VLAN to VNI, Flood List and Multicast Group Mappings

| VLAN | VNI | Flood List | Multicast Group |
| ---- | --- | ---------- | --------------- |
| 101 | 10101 | - | - |
| 102 | 10102 | - | - |

##### VRF to VNI and Multicast Group Mappings

| VRF | VNI | Multicast Group |
| ---- | --- | --------------- |
| VRF100 | 100 | 225.1.2.99 |

#### VXLAN Interface Device Configuration

```eos
!
interface Vxlan1
   description dc1-bl1_VTEP
   vxlan source-interface Loopback1
   vxlan udp-port 4789
   vxlan vlan 101 vni 10101
   vxlan vlan 102 vni 10102
   vxlan vrf VRF100 vni 100
   vxlan vrf VRF100 multicast group 225.1.2.99
```

## Routing

### Service Routing Protocols Model

Multi agent routing protocol model enabled

```eos
!
service routing protocols model multi-agent
```

### Virtual Router MAC Address

#### Virtual Router MAC Address Summary

Virtual Router MAC Address: 00:1c:73:00:00:99

#### Virtual Router MAC Address Device Configuration

```eos
!
ip virtual-router mac-address 00:1c:73:00:00:99
```

### IP Routing

#### IP Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | True |
| MGMT | False |
| VRF100 | True |

#### IP Routing Device Configuration

```eos
!
ip routing
no ip routing vrf MGMT
ip routing vrf VRF100
```

### IPv6 Routing

#### IPv6 Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | False |
| MGMT | false |
| VRF100 | false |

### Static Routes

#### Static Routes Summary

| VRF | Destination Prefix | Next Hop IP | Exit interface | Administrative Distance | Tag | Route Name | Metric |
| --- | ------------------ | ----------- | -------------- | ----------------------- | --- | ---------- | ------ |
| MGMT | 0.0.0.0/0 | 192.168.124.1 | - | 1 | - | - | - |

#### Static Routes Device Configuration

```eos
!
ip route vrf MGMT 0.0.0.0/0 192.168.124.1
```

### Router BGP

#### Router BGP Summary

| BGP AS | Router ID |
| ------ | --------- |
| 65104 | 10.255.1.6 |

| BGP Tuning |
| ---------- |
| no bgp default ipv4-unicast |
| maximum-paths 4 ecmp 4 |

#### Router BGP Peer Groups

##### EVPN-OVERLAY-PEERS

| Settings | Value |
| -------- | ----- |
| Address Family | evpn |
| Source | Loopback0 |
| BFD | True |
| Ebgp multihop | 3 |
| Send community | all |
| Maximum routes | 0 (no limit) |

##### IPv4-UNDERLAY-PEERS

| Settings | Value |
| -------- | ----- |
| Address Family | ipv4 |
| Send community | all |
| Maximum routes | 12000 |

#### BGP Neighbors

| Neighbor | Remote AS | VRF | Shutdown | Send-community | Maximum-routes | Allowas-in | BFD | RIB Pre-Policy Retain | Route-Reflector Client | Passive |
| -------- | --------- | --- | -------- | -------------- | -------------- | ---------- | --- | --------------------- | ---------------------- | ------- |
| 10.255.1.1 | 65100 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - |
| 10.255.1.2 | 65100 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - |
| 10.255.1.44 | 65100 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - |
| 10.255.1.46 | 65100 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - |
| 172.100.100.1 | 65203 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - |
| 10.0.0.1 | 65204 | VRF100 | - | standard | - | - | - | - | - | - |

#### Router BGP EVPN Address Family

##### EVPN Peer Groups

| Peer Group | Activate | Encapsulation |
| ---------- | -------- | ------------- |
| EVPN-OVERLAY-PEERS | True | default |

#### Router BGP VLAN Aware Bundles

| VLAN Aware Bundle | Route-Distinguisher | Both Route-Target | Import Route Target | Export Route-Target | Redistribute | VLANs |
| ----------------- | ------------------- | ----------------- | ------------------- | ------------------- | ------------ | ----- |
| VRF100 | 10.255.1.6:11100 | 11100:11100 | - | - | learned | 101-102 |

#### Router BGP VRFs

| VRF | Route-Distinguisher | Redistribute | EVPN Multicast |
| --- | ------------------- | ------------ | -------------- |
| VRF100 | 10.255.1.6:100 | connected | IPv4: True<br>Transit: True |

#### Router BGP Device Configuration

```eos
!
router bgp 65104
   router-id 10.255.1.6
   maximum-paths 4 ecmp 4
   no bgp default ipv4-unicast
   neighbor EVPN-OVERLAY-PEERS peer group
   neighbor EVPN-OVERLAY-PEERS update-source Loopback0
   neighbor EVPN-OVERLAY-PEERS bfd
   neighbor EVPN-OVERLAY-PEERS ebgp-multihop 3
   neighbor EVPN-OVERLAY-PEERS password 7 <removed>
   neighbor EVPN-OVERLAY-PEERS send-community
   neighbor EVPN-OVERLAY-PEERS maximum-routes 0
   neighbor IPv4-UNDERLAY-PEERS peer group
   neighbor IPv4-UNDERLAY-PEERS password 7 <removed>
   neighbor IPv4-UNDERLAY-PEERS send-community
   neighbor IPv4-UNDERLAY-PEERS maximum-routes 12000
   neighbor 10.255.1.1 peer group EVPN-OVERLAY-PEERS
   neighbor 10.255.1.1 remote-as 65100
   neighbor 10.255.1.1 description dc1-spine1
   neighbor 10.255.1.2 peer group EVPN-OVERLAY-PEERS
   neighbor 10.255.1.2 remote-as 65100
   neighbor 10.255.1.2 description dc1-spine2
   neighbor 10.255.1.44 peer group IPv4-UNDERLAY-PEERS
   neighbor 10.255.1.44 remote-as 65100
   neighbor 10.255.1.44 description dc1-spine1_Ethernet4
   neighbor 10.255.1.46 peer group IPv4-UNDERLAY-PEERS
   neighbor 10.255.1.46 remote-as 65100
   neighbor 10.255.1.46 description dc1-spine2_Ethernet4
   neighbor 172.100.100.1 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.100.100.1 remote-as 65203
   neighbor 172.100.100.1 local-as 65103 no-prepend replace-as
   neighbor 172.100.100.1 description dc2-bl1
   redistribute connected route-map RM-CONN-2-BGP
   !
   vlan-aware-bundle VRF100
      rd 10.255.1.6:11100
      route-target both 11100:11100
      redistribute learned
      vlan 101-102
   !
   address-family evpn
      neighbor EVPN-OVERLAY-PEERS activate
   !
   address-family ipv4
      no neighbor EVPN-OVERLAY-PEERS activate
      neighbor IPv4-UNDERLAY-PEERS activate
   !
   vrf VRF100
      rd 10.255.1.6:100
      evpn multicast
         address-family ipv4
            transit
      route-target import evpn 100:100
      route-target export evpn 100:100
      router-id 10.255.1.6
      neighbor 10.0.0.1 remote-as 65204
      neighbor 10.0.0.1 peer group DCI-VRF100
      neighbor 10.0.0.1 description dc1-bl2-vrf200
      neighbor 10.0.0.1 send-community standard
      redistribute connected
      !
      address-family ipv4
         neighbor 10.0.0.1 activate
```

## BFD

### Router BFD

#### Router BFD Singlehop Summary

| Interval | Minimum RX | Multiplier |
| -------- | ---------- | ---------- |
| 2000 | 2000 | 3 |

#### Router BFD Multihop Summary

| Interval | Minimum RX | Multiplier |
| -------- | ---------- | ---------- |
| 2000 | 2000 | 3 |

#### Router BFD Device Configuration

```eos
!
router bfd
   interval 2000 min-rx 2000 multiplier 3 default
   multihop interval 2000 min-rx 2000 multiplier 3
```

## Multicast

### IP IGMP Snooping

#### IP IGMP Snooping Summary

| IGMP Snooping | Fast Leave | Interface Restart Query | Proxy | Restart Query Interval | Robustness Variable |
| ------------- | ---------- | ----------------------- | ----- | ---------------------- | ------------------- |
| Enabled | - | - | - | - | - |

#### IP IGMP Snooping Device Configuration

```eos
```

### Router Multicast

#### IP Router Multicast Summary

- Routing for IPv4 multicast is enabled.
- Software forwarding by the Software Forwarding Engine (SFE)

#### IP Router Multicast VRFs

| VRF Name | Multicast Routing |
| -------- | ----------------- |
| VRF100 | enabled |

#### Router Multicast Device Configuration

```eos
!
router multicast
   ipv4
      routing
      software-forwarding sfe
   !
   vrf VRF100
      ipv4
         routing
```

### PIM Sparse Mode

#### Router PIM Sparse Mode

##### IP Sparse Mode Information

##### IP Sparse Mode VRFs

| VRF Name | BFD Enabled |
| -------- | ----------- |
| VRF100 | False |

| VRF Name | Rendezvous Point Address | Group Address | Access Lists | Priority | Hashmask | Override |
| -------- | ------------------------ | ------------- | ------------ | -------- | -------- | -------- |
| VRF100 | 12.12.12.12 | - | - | - | - | - |

##### Router Multicast Device Configuration

```eos
!
router pim sparse-mode
   !
   vrf VRF100
      ipv4
         rp address 12.12.12.12
```

#### PIM Sparse Mode Enabled Interfaces

| Interface Name | VRF Name | IP Version | DR Priority | Local Interface |
| -------------- | -------- | ---------- | ----------- | --------------- |
| Ethernet1 | - | IPv4 | - | - |
| Ethernet2 | - | IPv4 | - | - |
| Ethernet4.121 | VRF100 | IPv4 | - | - |

## Filters

### Prefix-lists

#### Prefix-lists Summary

##### PL-LOOPBACKS-EVPN-OVERLAY

| Sequence | Action |
| -------- | ------ |
| 10 | permit 10.255.1.0/28 eq 32 |
| 20 | permit 10.255.1.16/28 eq 32 |

#### Prefix-lists Device Configuration

```eos
!
ip prefix-list PL-LOOPBACKS-EVPN-OVERLAY
   seq 10 permit 10.255.1.0/28 eq 32
   seq 20 permit 10.255.1.16/28 eq 32
```

### Route-maps

#### Route-maps Summary

##### RM-CONN-2-BGP

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | permit | ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY | - | - | - |

#### Route-maps Device Configuration

```eos
!
route-map RM-CONN-2-BGP permit 10
   match ip address prefix-list PL-LOOPBACKS-EVPN-OVERLAY
```

## VRF Instances

### VRF Instances Summary

| VRF Name | IP Routing |
| -------- | ---------- |
| MGMT | disabled |
| VRF100 | enabled |

### VRF Instances Device Configuration

```eos
!
vrf instance MGMT
!
vrf instance VRF100
```

## Virtual Source NAT

### Virtual Source NAT Summary

| Source NAT VRF | Source NAT IP Address |
| -------------- | --------------------- |
| VRF100 | 10.255.100.6 |

### Virtual Source NAT Configuration

```eos
!
ip address virtual source-nat vrf VRF100 address 10.255.100.6
```
