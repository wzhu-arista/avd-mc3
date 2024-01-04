# dc2-bl2

## Table of Contents

- [Management](#management)
  - [Management Interfaces](#management-interfaces)
  - [Management API HTTP](#management-api-http)
- [Authentication](#authentication)
  - [Local Users](#local-users)
  - [AAA Authorization](#aaa-authorization)
- [Spanning Tree](#spanning-tree)
  - [Spanning Tree Summary](#spanning-tree-summary)
  - [Spanning Tree Device Configuration](#spanning-tree-device-configuration)
- [Internal VLAN Allocation Policy](#internal-vlan-allocation-policy)
  - [Internal VLAN Allocation Policy Summary](#internal-vlan-allocation-policy-summary)
  - [Internal VLAN Allocation Policy Configuration](#internal-vlan-allocation-policy-configuration)
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
| Management0 | oob_management | oob | MGMT | 192.168.124.120/24 | 192.168.124.1 |

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
   ip address 192.168.124.120/24
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

#### Management API HTTP Configuration

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

### Internal VLAN Allocation Policy Configuration

```eos
!
vlan internal order ascending range 1006 1199
```

## VLANs

### VLANs Summary

| VLAN ID | Name | Trunk Groups |
| ------- | ---- | ------------ |
| 201 | VRF200_VLAN201 | - |
| 202 | VRF200_VLAN202 | - |
| 211 | VRF210_VLAN211 | - |
| 212 | VRF210_VLAN212 | - |

### VLANs Device Configuration

```eos
!
vlan 201
   name VRF200_VLAN201
!
vlan 202
   name VRF200_VLAN202
!
vlan 211
   name VRF210_VLAN211
!
vlan 212
   name VRF210_VLAN212
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
| Ethernet4.122 | To-DC1-BL2-VRF100 | l3dot1q | - | 122 |

##### IPv4

| Interface | Description | Type | Channel Group | IP Address | VRF |  MTU | Shutdown | ACL In | ACL Out |
| --------- | ----------- | -----| ------------- | ---------- | ----| ---- | -------- | ------ | ------- |
| Ethernet1 | P2P_LINK_TO_DC2-SPINE1_Ethernet5 | routed | - | 10.255.2.49/31 | default | 1500 | False | - | - |
| Ethernet2 | P2P_LINK_TO_DC2-SPINE2_Ethernet5 | routed | - | 10.255.2.51/31 | default | 1500 | False | - | - |
| Ethernet4 | P2P_LINK_TO_dc1-bl2_Ethernet4 | routed | - | 172.100.100.3/31 | default | 1500 | False | - | - |
| Ethernet4.122 | To-DC1-BL2-VRF100 | l3dot1q | - | 10.0.0.3/31 | VRF200 | 1500 | False | - | - |

#### Ethernet Interfaces Device Configuration

```eos
!
interface Ethernet1
   description P2P_LINK_TO_DC2-SPINE1_Ethernet5
   no shutdown
   mtu 1500
   no switchport
   ip address 10.255.2.49/31
   pim ipv4 sparse-mode
!
interface Ethernet2
   description P2P_LINK_TO_DC2-SPINE2_Ethernet5
   no shutdown
   mtu 1500
   no switchport
   ip address 10.255.2.51/31
   pim ipv4 sparse-mode
!
interface Ethernet4
   description P2P_LINK_TO_dc1-bl2_Ethernet4
   no shutdown
   mtu 1500
   no switchport
   ip address 172.100.100.3/31
!
interface Ethernet4.122
   description To-DC1-BL2-VRF100
   no shutdown
   mtu 1500
   encapsulation dot1q vlan 122
   vrf VRF200
   ip address 10.0.0.3/31
```

### Loopback Interfaces

#### Loopback Interfaces Summary

##### IPv4

| Interface | Description | VRF | IP Address |
| --------- | ----------- | --- | ---------- |
| Loopback0 | EVPN_Overlay_Peering | default | 10.255.2.7/32 |
| Loopback1 | VTEP_VXLAN_Tunnel_Source | default | 10.255.2.23/32 |
| Loopback200 | VRF200_VTEP_DIAGNOSTICS | VRF200 | 10.255.200.7/32 |
| Loopback210 | VRF210_VTEP_DIAGNOSTICS | VRF210 | 10.255.210.7/32 |

##### IPv6

| Interface | Description | VRF | IPv6 Address |
| --------- | ----------- | --- | ------------ |
| Loopback0 | EVPN_Overlay_Peering | default | - |
| Loopback1 | VTEP_VXLAN_Tunnel_Source | default | - |
| Loopback200 | VRF200_VTEP_DIAGNOSTICS | VRF200 | - |
| Loopback210 | VRF210_VTEP_DIAGNOSTICS | VRF210 | - |


#### Loopback Interfaces Device Configuration

```eos
!
interface Loopback0
   description EVPN_Overlay_Peering
   no shutdown
   ip address 10.255.2.7/32
!
interface Loopback1
   description VTEP_VXLAN_Tunnel_Source
   no shutdown
   ip address 10.255.2.23/32
!
interface Loopback200
   description VRF200_VTEP_DIAGNOSTICS
   no shutdown
   vrf VRF200
   ip address 10.255.200.7/32
!
interface Loopback210
   description VRF210_VTEP_DIAGNOSTICS
   no shutdown
   vrf VRF210
   ip address 10.255.210.7/32
```

### VLAN Interfaces

#### VLAN Interfaces Summary

| Interface | Description | VRF |  MTU | Shutdown |
| --------- | ----------- | --- | ---- | -------- |
| Vlan201 | VRF200_VLAN201 | VRF200 | - | False |
| Vlan202 | VRF200_VLAN202 | VRF200 | - | False |
| Vlan211 | VRF210_VLAN211 | VRF210 | - | False |
| Vlan212 | VRF210_VLAN212 | VRF210 | - | False |

##### IPv4

| Interface | VRF | IP Address | IP Address Virtual | IP Router Virtual Address | VRRP | ACL In | ACL Out |
| --------- | --- | ---------- | ------------------ | ------------------------- | ---- | ------ | ------- |
| Vlan201 |  VRF200  |  -  |  10.10.201.1/24  |  -  |  -  |  -  |  -  |
| Vlan202 |  VRF200  |  -  |  10.10.202.1/24  |  -  |  -  |  -  |  -  |
| Vlan211 |  VRF210  |  -  |  10.10.211.1/24  |  -  |  -  |  -  |  -  |
| Vlan212 |  VRF210  |  -  |  10.10.212.1/24  |  -  |  -  |  -  |  -  |

#### VLAN Interfaces Device Configuration

```eos
!
interface Vlan201
   description VRF200_VLAN201
   no shutdown
   vrf VRF200
   ip igmp
   pim ipv4 local-interface Loopback200
   ip address virtual 10.10.201.1/24
!
interface Vlan202
   description VRF200_VLAN202
   no shutdown
   vrf VRF200
   ip igmp
   pim ipv4 local-interface Loopback200
   ip address virtual 10.10.202.1/24
!
interface Vlan211
   description VRF210_VLAN211
   no shutdown
   vrf VRF210
   ip igmp
   pim ipv4 local-interface Loopback210
   ip address virtual 10.10.211.1/24
!
interface Vlan212
   description VRF210_VLAN212
   no shutdown
   vrf VRF210
   ip igmp
   pim ipv4 local-interface Loopback210
   ip address virtual 10.10.212.1/24
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
| 201 | 20201 | - | - |
| 202 | 20202 | - | - |
| 211 | 20211 | - | - |
| 212 | 20212 | - | - |

##### VRF to VNI and Multicast Group Mappings

| VRF | VNI | Multicast Group |
| ---- | --- | --------------- |
| VRF200 | 200 | 225.2.2.200 |
| VRF210 | 210 | 225.2.2.210 |

#### VXLAN Interface Device Configuration

```eos
!
interface Vxlan1
   description dc2-bl2_VTEP
   vxlan source-interface Loopback1
   vxlan udp-port 4789
   vxlan vlan 201 vni 20201
   vxlan vlan 202 vni 20202
   vxlan vlan 211 vni 20211
   vxlan vlan 212 vni 20212
   vxlan vrf VRF200 vni 200
   vxlan vrf VRF210 vni 210
   vxlan vrf VRF200 multicast group 225.2.2.200
   vxlan vrf VRF210 multicast group 225.2.2.210
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

##### Virtual Router MAC Address: 00:1c:73:00:00:99

#### Virtual Router MAC Address Configuration

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
| VRF200 | True |
| VRF210 | True |

#### IP Routing Device Configuration

```eos
!
ip routing
no ip routing vrf MGMT
ip routing vrf VRF200
ip routing vrf VRF210
```

### IPv6 Routing

#### IPv6 Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | False |
| MGMT | false |
| VRF200 | false |
| VRF210 | false |

### Static Routes

#### Static Routes Summary

| VRF | Destination Prefix | Next Hop IP             | Exit interface      | Administrative Distance       | Tag               | Route Name                    | Metric         |
| --- | ------------------ | ----------------------- | ------------------- | ----------------------------- | ----------------- | ----------------------------- | -------------- |
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
| 65204 | 10.255.2.7 |

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
| 10.255.2.1 | 65200 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - |
| 10.255.2.2 | 65200 | default | - | Inherited from peer group EVPN-OVERLAY-PEERS | Inherited from peer group EVPN-OVERLAY-PEERS | - | Inherited from peer group EVPN-OVERLAY-PEERS | - | - | - |
| 10.255.2.48 | 65200 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - |
| 10.255.2.50 | 65200 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - |
| 172.100.100.2 | 65104 | default | - | Inherited from peer group IPv4-UNDERLAY-PEERS | Inherited from peer group IPv4-UNDERLAY-PEERS | - | - | - | - | - |
| 10.0.0.2 | 65103 | VRF200 | - | standard | - | - | - | - | - | - |

#### Router BGP EVPN Address Family

##### EVPN Peer Groups

| Peer Group | Activate | Encapsulation |
| ---------- | -------- | ------------- |
| EVPN-OVERLAY-PEERS | True | default |

#### Router BGP VLAN Aware Bundles

| VLAN Aware Bundle | Route-Distinguisher | Both Route-Target | Import Route Target | Export Route-Target | Redistribute | VLANs |
| ----------------- | ------------------- | ----------------- | ------------------- | ------------------- | ------------ | ----- |
| VRF200 | 10.255.2.7:21200 | 21200:21200 | - | - | learned | 201-202 |
| VRF210 | 10.255.2.7:21210 | 21210:21210 | - | - | learned | 211-212 |

#### Router BGP VRFs

| VRF | Route-Distinguisher | Redistribute | EVPN Multicast |
| --- | ------------------- | ------------ | -------------- |
| VRF200 | 10.255.2.7:200 | connected | IPv4: True<br>Transit: False |
| VRF210 | 10.255.2.7:210 | connected | IPv4: True<br>Transit: False |

#### Router BGP Device Configuration

```eos
!
router bgp 65204
   router-id 10.255.2.7
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
   neighbor 10.255.2.1 peer group EVPN-OVERLAY-PEERS
   neighbor 10.255.2.1 remote-as 65200
   neighbor 10.255.2.1 description dc2-spine1
   neighbor 10.255.2.2 peer group EVPN-OVERLAY-PEERS
   neighbor 10.255.2.2 remote-as 65200
   neighbor 10.255.2.2 description dc2-spine2
   neighbor 10.255.2.48 peer group IPv4-UNDERLAY-PEERS
   neighbor 10.255.2.48 remote-as 65200
   neighbor 10.255.2.48 description dc2-spine1_Ethernet5
   neighbor 10.255.2.50 peer group IPv4-UNDERLAY-PEERS
   neighbor 10.255.2.50 remote-as 65200
   neighbor 10.255.2.50 description dc2-spine2_Ethernet5
   neighbor 172.100.100.2 peer group IPv4-UNDERLAY-PEERS
   neighbor 172.100.100.2 remote-as 65104
   neighbor 172.100.100.2 description dc1-bl2
   redistribute connected route-map RM-CONN-2-BGP
   !
   vlan-aware-bundle VRF200
      rd 10.255.2.7:21200
      route-target both 21200:21200
      redistribute learned
      vlan 201-202
   !
   vlan-aware-bundle VRF210
      rd 10.255.2.7:21210
      route-target both 21210:21210
      redistribute learned
      vlan 211-212
   !
   address-family evpn
      neighbor EVPN-OVERLAY-PEERS activate
   !
   address-family ipv4
      no neighbor EVPN-OVERLAY-PEERS activate
      neighbor IPv4-UNDERLAY-PEERS activate
   !
   vrf VRF200
      rd 10.255.2.7:200
      evpn multicast
      route-target import evpn 200:200
      route-target export evpn 200:200
      router-id 10.255.2.7
      neighbor 10.0.0.2 remote-as 65103
      neighbor 10.0.0.2 peer group DCI-VRF200
      neighbor 10.0.0.2 description dc1-bl2-vrf100
      neighbor 10.0.0.2 send-community standard
      redistribute connected
      !
      address-family ipv4
         neighbor 10.0.0.2 activate
   !
   vrf VRF210
      rd 10.255.2.7:210
      evpn multicast
      route-target import evpn 210:210
      route-target export evpn 210:210
      router-id 10.255.2.7
      redistribute connected
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
| VRF200 | enabled |
| VRF210 | enabled |

#### Router Multicast Device Configuration

```eos
!
router multicast
   ipv4
      routing
      software-forwarding sfe
   !
   vrf VRF200
      ipv4
         routing
   !
   vrf VRF210
      ipv4
         routing
```


### PIM Sparse Mode

#### PIM Sparse Mode enabled interfaces

| Interface Name | VRF Name | IP Version | DR Priority | Local Interface |
| -------------- | -------- | ---------- | ----------- | --------------- |
| Ethernet1 | - | IPv4 | - | - |
| Ethernet2 | - | IPv4 | - | - |

## Filters

### Prefix-lists

#### Prefix-lists Summary

##### PL-LOOPBACKS-EVPN-OVERLAY

| Sequence | Action |
| -------- | ------ |
| 10 | permit 10.255.2.0/28 eq 32 |
| 20 | permit 10.255.2.16/28 eq 32 |

#### Prefix-lists Device Configuration

```eos
!
ip prefix-list PL-LOOPBACKS-EVPN-OVERLAY
   seq 10 permit 10.255.2.0/28 eq 32
   seq 20 permit 10.255.2.16/28 eq 32
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
| VRF200 | enabled |
| VRF210 | enabled |

### VRF Instances Device Configuration

```eos
!
vrf instance MGMT
!
vrf instance VRF200
!
vrf instance VRF210
```

## Virtual Source NAT

### Virtual Source NAT Summary

| Source NAT VRF | Source NAT IP Address |
| -------------- | --------------------- |
| VRF200 | 10.255.200.7 |
| VRF210 | 10.255.210.7 |

### Virtual Source NAT Configuration

```eos
!
ip address virtual source-nat vrf VRF200 address 10.255.200.7
ip address virtual source-nat vrf VRF210 address 10.255.210.7
```
