# DC1-LEAF5
# Table of Contents

- [Management](#management)
  - [Management Interfaces](#management-interfaces)
  - [Name Servers](#name-servers)
  - [Domain Lookup](#domain-lookup)
  - [Clock Settings](#clock-settings)
  - [NTP](#ntp)
  - [Management SSH](#management-ssh)
  - [Management API HTTP](#management-api-http)
  - [IP HTTP Client Source Interfaces](#ip-http-client-source-interfaces)
- [Authentication](#authentication)
  - [Local Users](#local-users)
  - [TACACS Servers](#tacacs-servers)
  - [IP TACACS Source Interfaces](#ip-tacacs-source-interfaces)
  - [IP RADIUS Source Interfaces](#ip-radius-source-interfaces)
  - [AAA Server Groups](#aaa-server-groups)
  - [AAA Authentication](#aaa-authentication)
  - [AAA Authorization](#aaa-authorization)
- [Monitoring](#monitoring)
  - [Logging](#logging)
  - [SNMP](#snmp)
- [MLAG](#mlag)
  - [MLAG Summary](#mlag-summary)
  - [MLAG Device Configuration](#mlag-device-configuration)
- [LLDP](#lldp)
  - [LLDP Summary](#lldp-summary)
  - [LLDP Device Configuration](#lldp-device-configuration)
- [Spanning Tree](#spanning-tree)
  - [Spanning Tree Summary](#spanning-tree-summary)
  - [Spanning Tree Device Configuration](#spanning-tree-device-configuration)
- [Internal VLAN Allocation Policy](#internal-vlan-allocation-policy)
  - [Internal VLAN Allocation Policy Summary](#internal-vlan-allocation-policy-summary)
  - [Internal VLAN Allocation Policy Configuration](#internal-vlan-allocation-policy-configuration)
- [VLANs](#vlans)
  - [VLANs Summary](#vlans-summary)
  - [VLANs Device Configuration](#vlans-device-configuration)
- [MAC Address Table](#mac-address-table)
  - [MAC Address Table Summary](#mac-address-table-summary)
  - [MAC Address Table Device Configuration](#mac-address-table-device-configuration)
- [Interfaces](#interfaces)
  - [Switchport Default](#switchport-default)
  - [Ethernet Interfaces](#ethernet-interfaces)
  - [Port-Channel Interfaces](#port-channel-interfaces)
  - [Loopback Interfaces](#loopback-interfaces)
  - [VLAN Interfaces](#vlan-interfaces)
  - [VXLAN Interface](#vxlan-interface)
- [Routing](#routing)
  - [Service Routing Protocols Model](#service-routing-protocols-model)
  - [Virtual Router MAC Address](#virtual-router-mac-address)
  - [IP Routing](#ip-routing)
  - [IPv6 Routing](#ipv6-routing)
  - [Static Routes](#static-routes)
  - [ARP](#arp)
  - [Router OSPF](#router-ospf)
  - [Router BGP](#router-bgp)
- [BFD](#bfd)
  - [Router BFD](#router-bfd)
- [Multicast](#multicast)
  - [IP IGMP Snooping](#ip-igmp-snooping)
- [Filters](#filters)
  - [Route-maps](#route-maps)
  - [IP Extended Community Lists](#ip-extended-community-lists)
- [ACL](#acl)
- [VRF Instances](#vrf-instances)
  - [VRF Instances Summary](#vrf-instances-summary)
  - [VRF Instances Device Configuration](#vrf-instances-device-configuration)
- [Quality Of Service](#quality-of-service)

# Management

## Management Interfaces

### Management Interfaces Summary

#### IPv4

| Management Interface | description | Type | VRF | IP Address | Gateway |
| -------------------- | ----------- | ---- | --- | ---------- | ------- |
| Management0 | oob_management | oob | MGMT | 172.100.100.107/23 | 172.100.100.1 |

#### IPv6

| Management Interface | description | Type | VRF | IPv6 Address | IPv6 Gateway |
| -------------------- | ----------- | ---- | --- | ------------ | ------------ |
| Management0 | oob_management | oob | MGMT | - | - |

### Management Interfaces Device Configuration

```eos
!
interface Management0
   description oob_management
   no shutdown
   vrf MGMT
   ip address 172.100.100.107/23
```

## Name Servers

### Name Servers Summary

| Name Server | Source VRF |
| ----------- | ---------- |
| 10.201.0.10 | MGMT |
| 10.202.0.10 | MGMT |

### Name Servers Device Configuration

```eos
ip name-server vrf MGMT 10.201.0.10
ip name-server vrf MGMT 10.202.0.10
```

## Domain Lookup

### DNS Domain Lookup Summary

| Source interface | vrf |
| ---------------- | --- |
| Management1 | MGMT |

### DNS Domain Lookup Device Configuration

```eos
ip domain lookup vrf MGMT source-interface Management1
```

## Clock Settings

### Clock Timezone Settings

Clock Timezone is set to **America/Detroit**.

### Clock Configuration

```eos
!
clock timezone America/Detroit
```

## NTP

### NTP Summary

#### NTP Local Interface

| Interface | VRF |
| --------- | --- |
| Management1 | MGMT |

#### NTP Servers

| Server | VRF | Preferred | Burst | iBurst | Version | Min Poll | Max Poll | Local-interface | Key |
| ------ | --- | --------- | ----- | ------ | ------- | -------- | -------- | --------------- | --- |
| 10.201.0.10 | MGMT | True | - | - | - | - | - | - | - |
| 10.202.0.10 | MGMT | - | - | - | - | - | - | - | - |

### NTP Device Configuration

```eos
!
ntp local-interface vrf MGMT Management1
ntp server vrf MGMT 10.201.0.10 prefer
ntp server vrf MGMT 10.202.0.10
```

## Management SSH


### SSH timeout and management

| Idle Timeout | SSH Management |
| ------------ | -------------- |
| default | Enabled |

### Max number of SSH sessions limit and per-host limit

| Connection Limit | Max from a single Host |
| ---------------- | ---------------------- |
| - | - |

### Ciphers and algorithms

| Ciphers | Key-exchange methods | MAC algorithms | Hostkey server algorithms |
|---------|----------------------|----------------|---------------------------|
| default | default | default | default |

### VRFs

| VRF | Status |
| --- | ------ |
| default | Disabled |
| MGMT | Enabled |

### Management SSH Configuration

```eos
!
management ssh
   !
   vrf default
      shutdown
   !
   vrf MGMT
      no shutdown
```

## Management API HTTP

### Management API HTTP Summary

| HTTP | HTTPS | Default Services |
| ---- | ----- | ---------------- |
| False | True | - |

### Management API VRF Access

| VRF Name | IPv4 ACL | IPv6 ACL |
| -------- | -------- | -------- |
| MGMT | - | - |

### Management API HTTP Configuration

```eos
!
management api http-commands
   protocol https
   no shutdown
   !
   vrf MGMT
      no shutdown
```

## IP HTTP Client Source Interfaces

### IP HTTP Client Source Interfaces

| VRF | Source Interface Name |
| --- | --------------- |
| MGMT | Management1 |

### IP HTTP Client Source Interfaces Device Configuration

```eos
!
ip http client local-interface Management1 vrf MGMT
```

# Authentication

## Local Users

### Local Users Summary

| User | Privilege | Role | Disabled |
| ---- | --------- | ---- | -------- |
| admin | 15 | network-admin | False |

### Local Users Device Configuration

```eos
!
username admin privilege 15 role network-admin secret sha512 $6$eucN5ngreuExDgwS$xnD7T8jO..GBDX0DUlp.hn.W7yW94xTjSanqgaQGBzPIhDAsyAl9N4oScHvOMvf07uVBFI4mKMxwdVEUVKgY/.
```

## TACACS Servers

### TACACS Servers

| VRF | TACACS Servers | Single-Connection |
| --- | -------------- | ----------------- |
| MGMT | 10.100.0.156 | False |
| MGMT | 10.100.0.157 | False |

### TACACS Servers Device Configuration

```eos
!
tacacs-server host 10.100.0.156 vrf MGMT key 7 055A0A5D311E1E5B4944
tacacs-server host 10.100.0.157 vrf MGMT key 7 055A0A5D311E1E5B4944
```

## IP TACACS Source Interfaces

### IP TACACS Source Interfaces

| VRF | Source Interface Name |
| --- | --------------- |
| MGMT | Management1 |

### IP TACACS Source Interfaces Device Configuration

```eos
!
ip tacacs vrf MGMT source-interface Management1
```

## IP RADIUS Source Interfaces

### IP RADIUS Source Interfaces

| VRF | Source Interface Name |
| --- | --------------- |
| MGMT | Management1 |

### IP SOURCE Source Interfaces Device Configuration

```eos
!
ip radius vrf MGMT source-interface Management1
```

## AAA Server Groups

### AAA Server Groups Summary

| Server Group Name | Type  | VRF | IP address |
| ------------------| ----- | --- | ---------- |
| tacacs_group_1 | tacacs+ | MGMT | 10.100.0.156 |
| tacacs_group_1 | tacacs+ | MGMT | 10.100.0.157 |

### AAA Server Groups Device Configuration

```eos
!
aaa group server tacacs+ tacacs_group_1
   server 10.100.0.156 vrf MGMT
   server 10.100.0.157 vrf MGMT
```

## AAA Authentication

### AAA Authentication Summary

| Type | Sub-type | User Stores |
| ---- | -------- | ---------- |
| Login | default | group tacacs_group_1 local |

### AAA Authentication Device Configuration

```eos
aaa authentication login default group tacacs_group_1 local
!
```

## AAA Authorization

### AAA Authorization Summary

| Type | User Stores |
| ---- | ----------- |
| Exec | group tacacs_group_1 local |

Authorization for configuration commands is disabled.

### AAA Authorization Device Configuration

```eos
aaa authorization exec default group tacacs_group_1 local
!
```

# Monitoring

## Logging

### Logging Servers and Features Summary

| Type | Level |
| -----| ----- |

| VRF | Source Interface |
| --- | ---------------- |
| MGMT | Management1 |

| VRF | Hosts | Ports | Protocol |
| --- | ----- | ----- | -------- |
| MGMT | 10.201.0.108 | Default | UDP |
| MGMT | 10.202.0.108 | Default | UDP |

### Logging Servers and Features Device Configuration

```eos
!
logging vrf MGMT host 10.201.0.108
logging vrf MGMT host 10.202.0.108
logging vrf MGMT source-interface Management1
```

## SNMP

### SNMP Configuration Summary

| Contact | Location | SNMP Traps | State |
| ------- | -------- | ---------- | ----- |
| - | - | All | Enabled |

### SNMP Local Interfaces

| Local Interface | VRF |
| --------------- | --- |
| Management1 | MGMT |

### SNMP VRF Status

| VRF | Status |
| --- | ------ |
| default | Disabled |
| MGMT | Enabled |

### SNMP Hosts Configuration

| Host | VRF | Community | Username | Authentication level | SNMP Version |
| ---- |---- | --------- | -------- | -------------------- | ------------ |
| 10.100.0.11 | MGMT | PlaceHolderCommunity | - | - | 2c |
| 10.100.0.12 | MGMT | PlaceHolderCommunity | - | - | 2c |

### SNMP Communities

| Community | Access | Access List IPv4 | Access List IPv6 | View |
| --------- | ------ | ---------------- | ---------------- | ---- |
| PlaceHolderCommunity | ro | AL-NETWORK-MANAGEMENT | - | - |

### SNMP Device Configuration

```eos
!
snmp-server vrf MGMT local-interface Management1
snmp-server community PlaceHolderCommunity ro AL-NETWORK-MANAGEMENT
snmp-server host 10.100.0.11 vrf MGMT version 2c PlaceHolderCommunity
snmp-server host 10.100.0.12 vrf MGMT version 2c PlaceHolderCommunity
snmp-server enable traps
no snmp-server vrf default
snmp-server vrf MGMT
```

# MLAG

## MLAG Summary

| Domain-id | Local-interface | Peer-address | Peer-link |
| --------- | --------------- | ------------ | --------- |
| LeafPair3 | Vlan4094 | 192.0.0.29 | Port-Channel1000 |

Dual primary detection is disabled.

## MLAG Device Configuration

```eos
!
mlag configuration
   domain-id LeafPair3
   local-interface Vlan4094
   peer-address 192.0.0.29
   peer-link Port-Channel1000
   reload-delay mlag 300
   reload-delay non-mlag 330
```

# LLDP

## LLDP Summary

### LLDP Global Settings

| Enabled | Management Address | Management VRF | Timer | Hold-Time | Re-initialization Timer | Drop Received Tagged Packets |
| ------- | ------------------ | -------------- | ----- | --------- | ----------------------- | ---------------------------- |
| True | management1 | MGMT | 30 | 120 | 2 | - |

### LLDP Interface Settings

| Interface | Transmit | Receive |
| --------- | -------- | ------- |

## LLDP Device Configuration

```eos
!
lldp management-address management1
lldp management-address vrf MGMT
```

# Spanning Tree

## Spanning Tree Summary

STP mode: **rapid-pvst**

### Rapid-PVST Instance and Priority

| Instance(s) | Priority |
| -------- | -------- |
| 1-4094 | 0 |

### Global Spanning-Tree Settings

- Spanning Tree disabled for VLANs: **4093-4094**
- Global BPDU Guard for Edge ports is enabled.

## Spanning Tree Device Configuration

```eos
!
spanning-tree mode rapid-pvst
no spanning-tree vlan-id 4093-4094
spanning-tree edge-port bpduguard default
spanning-tree vlan-id 1-4094 priority 0
```

# Internal VLAN Allocation Policy

## Internal VLAN Allocation Policy Summary

| Policy Allocation | Range Beginning | Range Ending |
| ------------------| --------------- | ------------ |
| ascending | 1006 | 1199 |

## Internal VLAN Allocation Policy Configuration

```eos
!
vlan internal order ascending range 1006 1199
```

# VLANs

## VLANs Summary

| VLAN ID | Name | Trunk Groups |
| ------- | ---- | ------------ |
| 10 | Ten | - |
| 20 | Twenty | - |
| 30 | Thirty | - |
| 40 | Forty | - |
| 50 | Fifty | - |
| 4001 | MLAG_iBGP_CORP | LEAF_PEER_L3 |
| 4093 | LEAF_PEER_L3 | LEAF_PEER_L3 |
| 4094 | MLAG_PEER | MLAG |

## VLANs Device Configuration

```eos
!
vlan 10
   name Ten
!
vlan 20
   name Twenty
!
vlan 30
   name Thirty
!
vlan 40
   name Forty
!
vlan 50
   name Fifty
!
vlan 4001
   name MLAG_iBGP_CORP
   trunk group LEAF_PEER_L3
!
vlan 4093
   name LEAF_PEER_L3
   trunk group LEAF_PEER_L3
!
vlan 4094
   name MLAG_PEER
   trunk group MLAG
```

# MAC Address Table

## MAC Address Table Summary

- MAC address table entry maximum age: 1800 seconds

## MAC Address Table Device Configuration

```eos
!
mac address-table aging-time 1800
```

# Interfaces

## Switchport Default

### Switchport Defaults Summary

- Default Switchport Mode: routed

### Switchport Default Configuration

```eos
!
switchport default mode routed
```

## Ethernet Interfaces

### Ethernet Interfaces Summary

#### L2

| Interface | Description | Mode | VLANs | Native VLAN | Trunk Group | Channel-Group |
| --------- | ----------- | ---- | ----- | ----------- | ----------- | ------------- |
| Ethernet3 | HOSTE_eth1 | *access | *10 | *- | *- | 3 |
| Ethernet4 | HOSTF_eth1 | *access | *30 | *- | *- | 4 |
| Ethernet5 | MLAG_PEER_DC1-LEAF6_Ethernet5 | *trunk | *2-4094 | *- | *['LEAF_PEER_L3', 'MLAG'] | 1000 |
| Ethernet6 | MLAG_PEER_DC1-LEAF6_Ethernet6 | *trunk | *2-4094 | *- | *['LEAF_PEER_L3', 'MLAG'] | 1000 |

*Inherited from Port-Channel Interface

#### IPv4

| Interface | Description | Type | Channel Group | IP Address | VRF |  MTU | Shutdown | ACL In | ACL Out |
| --------- | ----------- | -----| ------------- | ---------- | ----| ---- | -------- | ------ | ------- |
| Ethernet1 | P2P_LINK_TO_DC1-SPINE1_Ethernet5 | routed | - | 10.0.0.57/31 | default | 9214 | False | - | - |
| Ethernet2 | P2P_LINK_TO_DC1-SPINE2_Ethernet5 | routed | - | 10.0.0.59/31 | default | 9214 | False | - | - |

### Ethernet Interfaces Device Configuration

```eos
!
interface Ethernet1
   description P2P_LINK_TO_DC1-SPINE1_Ethernet5
   no shutdown
   mtu 9214
   no switchport
   ip address 10.0.0.57/31
   ip ospf network point-to-point
   ip ospf area 0.0.0.0
!
interface Ethernet2
   description P2P_LINK_TO_DC1-SPINE2_Ethernet5
   no shutdown
   mtu 9214
   no switchport
   ip address 10.0.0.59/31
   ip ospf network point-to-point
   ip ospf area 0.0.0.0
!
interface Ethernet3
   description HOSTE_eth1
   no shutdown
   channel-group 3 mode active
!
interface Ethernet4
   description HOSTF_eth1
   no shutdown
   channel-group 4 mode active
!
interface Ethernet5
   description MLAG_PEER_DC1-LEAF6_Ethernet5
   no shutdown
   channel-group 1000 mode active
!
interface Ethernet6
   description MLAG_PEER_DC1-LEAF6_Ethernet6
   no shutdown
   channel-group 1000 mode active
```

## Port-Channel Interfaces

### Port-Channel Interfaces Summary

#### L2

| Interface | Description | Type | Mode | VLANs | Native VLAN | Trunk Group | LACP Fallback Timeout | LACP Fallback Mode | MLAG ID | EVPN ESI |
| --------- | ----------- | ---- | ---- | ----- | ----------- | ------------| --------------------- | ------------------ | ------- | -------- |
| Port-Channel3 | HOSTE | switched | access | 10 | - | - | - | - | 3 | - |
| Port-Channel4 | HOSTF | switched | access | 30 | - | - | - | - | 4 | - |
| Port-Channel1000 | MLAG_PEER_DC1-LEAF6_Po1000 | switched | trunk | 2-4094 | - | ['LEAF_PEER_L3', 'MLAG'] | - | - | - | - |

### Port-Channel Interfaces Device Configuration

```eos
!
interface Port-Channel3
   description HOSTE
   no shutdown
   switchport
   switchport access vlan 10
   mlag 3
   spanning-tree portfast
!
interface Port-Channel4
   description HOSTF
   no shutdown
   switchport
   switchport access vlan 30
   mlag 4
   spanning-tree portfast
!
interface Port-Channel1000
   description MLAG_PEER_DC1-LEAF6_Po1000
   no shutdown
   switchport
   switchport trunk allowed vlan 2-4094
   switchport mode trunk
   switchport trunk group LEAF_PEER_L3
   switchport trunk group MLAG
```

## Loopback Interfaces

### Loopback Interfaces Summary

#### IPv4

| Interface | Description | VRF | IP Address |
| --------- | ----------- | --- | ---------- |
| Loopback0 | EVPN_Overlay_Peering | default | 1.1.1.15/32 |
| Loopback1 | VTEP_VXLAN_Tunnel_Source | default | 2.2.2.15/32 |

#### IPv6

| Interface | Description | VRF | IPv6 Address |
| --------- | ----------- | --- | ------------ |
| Loopback0 | EVPN_Overlay_Peering | default | - |
| Loopback1 | VTEP_VXLAN_Tunnel_Source | default | - |


### Loopback Interfaces Device Configuration

```eos
!
interface Loopback0
   description EVPN_Overlay_Peering
   no shutdown
   ip address 1.1.1.15/32
   ip ospf area 0.0.0.0
!
interface Loopback1
   description VTEP_VXLAN_Tunnel_Source
   no shutdown
   ip address 2.2.2.15/32
   ip ospf area 0.0.0.0
```

## VLAN Interfaces

### VLAN Interfaces Summary

| Interface | Description | VRF |  MTU | Shutdown |
| --------- | ----------- | --- | ---- | -------- |
| Vlan10 | App Servers | CORP | 9014 | False |
| Vlan20 | Web Servers | CORP | 9014 | False |
| Vlan30 | DB Servers | CORP | 9014 | False |
| Vlan4001 | MLAG_PEER_L3_iBGP: vrf CORP | CORP | 9214 | False |
| Vlan4093 | MLAG_PEER_L3_PEERING | default | 9214 | False |
| Vlan4094 | MLAG_PEER | default | 9214 | False |

#### IPv4

| Interface | VRF | IP Address | IP Address Virtual | IP Router Virtual Address | VRRP | ACL In | ACL Out |
| --------- | --- | ---------- | ------------------ | ------------------------- | ---- | ------ | ------- |
| Vlan10 |  CORP  |  -  |  10.10.10.1/24  |  -  |  -  |  -  |  -  |
| Vlan20 |  CORP  |  -  |  10.20.20.1/24  |  -  |  -  |  -  |  -  |
| Vlan30 |  CORP  |  -  |  10.30.30.1/24  |  -  |  -  |  -  |  -  |
| Vlan4001 |  CORP  |  192.2.2.28/31  |  -  |  -  |  -  |  -  |  -  |
| Vlan4093 |  default  |  172.16.0.28/31  |  -  |  -  |  -  |  -  |  -  |
| Vlan4094 |  default  |  192.0.0.28/31  |  -  |  -  |  -  |  -  |  -  |

### VLAN Interfaces Device Configuration

```eos
!
interface Vlan10
   description App Servers
   no shutdown
   mtu 9014
   vrf CORP
   ip address virtual 10.10.10.1/24
!
interface Vlan20
   description Web Servers
   no shutdown
   mtu 9014
   vrf CORP
   ip address virtual 10.20.20.1/24
!
interface Vlan30
   description DB Servers
   no shutdown
   mtu 9014
   vrf CORP
   ip address virtual 10.30.30.1/24
!
interface Vlan4001
   description MLAG_PEER_L3_iBGP: vrf CORP
   no shutdown
   mtu 9214
   vrf CORP
   ip address 192.2.2.28/31
!
interface Vlan4093
   description MLAG_PEER_L3_PEERING
   no shutdown
   mtu 9214
   ip address 172.16.0.28/31
   ip ospf network point-to-point
   ip ospf area 0.0.0.0
!
interface Vlan4094
   description MLAG_PEER
   no shutdown
   mtu 9214
   no autostate
   ip address 192.0.0.28/31
```

## VXLAN Interface

### VXLAN Interface Summary

| Setting | Value |
| ------- | ----- |
| Source Interface | Loopback1 |
| UDP port | 4789 |
| EVPN MLAG Shared Router MAC | mlag-system-id |

#### VLAN to VNI, Flood List and Multicast Group Mappings

| VLAN | VNI | Flood List | Multicast Group |
| ---- | --- | ---------- | --------------- |
| 10 | 10010 | - | - |
| 20 | 10020 | - | - |
| 30 | 10030 | - | - |
| 40 | 10040 | - | - |
| 50 | 10050 | - | - |

#### VRF to VNI and Multicast Group Mappings

| VRF | VNI | Multicast Group |
| ---- | --- | --------------- |
| CORP | 50001 | - |

### VXLAN Interface Device Configuration

```eos
!
interface Vxlan1
   description DC1-LEAF5_VTEP
   vxlan source-interface Loopback1
   vxlan virtual-router encapsulation mac-address mlag-system-id
   vxlan udp-port 4789
   vxlan vlan 10 vni 10010
   vxlan vlan 20 vni 10020
   vxlan vlan 30 vni 10030
   vxlan vlan 40 vni 10040
   vxlan vlan 50 vni 10050
   vxlan vrf CORP vni 50001
```

# Routing
## Service Routing Protocols Model

Multi agent routing protocol model enabled

```eos
!
service routing protocols model multi-agent
```

## Virtual Router MAC Address

### Virtual Router MAC Address Summary

#### Virtual Router MAC Address: 00:1c:73:00:00:01

### Virtual Router MAC Address Configuration

```eos
!
ip virtual-router mac-address 00:1c:73:00:00:01
```

## IP Routing

### IP Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | True |
| CORP | true |
| MGMT | false |

### IP Routing Device Configuration

```eos
!
ip routing
ip routing vrf CORP
no ip routing vrf MGMT
```
## IPv6 Routing

### IPv6 Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | False |
| CORP | false |
| MGMT | false |

## Static Routes

### Static Routes Summary

| VRF | Destination Prefix | Next Hop IP             | Exit interface      | Administrative Distance       | Tag               | Route Name                    | Metric         |
| --- | ------------------ | ----------------------- | ------------------- | ----------------------------- | ----------------- | ----------------------------- | -------------- |
| MGMT | 0.0.0.0/0 | 172.100.100.1 | - | 1 | - | - | - |

### Static Routes Device Configuration

```eos
!
ip route vrf MGMT 0.0.0.0/0 172.100.100.1
```

## ARP

Global ARP timeout: 1500

## Router OSPF

### Router OSPF Summary

| Process ID | Router ID | Default Passive Interface | No Passive Interface | BFD | Max LSA | Default Information Originate | Log Adjacency Changes Detail | Auto Cost Reference Bandwidth | Maximum Paths | MPLS LDP Sync Default | Distribute List In |
| ---------- | --------- | ------------------------- | -------------------- | --- | ------- | ----------------------------- | ---------------------------- | ----------------------------- | ------------- | --------------------- | ------------------ |
| 100 | 1.1.1.15 | enabled | Ethernet1 <br> Ethernet2 <br> Vlan4093 <br> | disabled | 12000 | disabled | disabled | - | - | - | - |

### OSPF Interfaces

| Interface | Area | Cost | Point To Point |
| -------- | -------- | -------- | -------- |
| Ethernet1 | 0.0.0.0 | - | True |
| Ethernet2 | 0.0.0.0 | - | True |
| Vlan4093 | 0.0.0.0 | - | True |
| Loopback0 | 0.0.0.0 | - | - |
| Loopback1 | 0.0.0.0 | - | - |

### Router OSPF Device Configuration

```eos
!
router ospf 100
   router-id 1.1.1.15
   passive-interface default
   no passive-interface Ethernet1
   no passive-interface Ethernet2
   no passive-interface Vlan4093
   max-lsa 12000
```

## Router BGP

### Router BGP Summary

| BGP AS | Router ID |
| ------ | --------- |
| 65000|  1.1.1.15 |

| BGP Tuning |
| ---------- |
| no bgp default ipv4-unicast |
| distance bgp 20 200 200 |
| neighbor default send-community |
| graceful-restart restart-time 300 |
| graceful-restart |
| maximum-paths 4 ecmp 4 |

### Router BGP Peer Groups

#### EVPN-OVERLAY-LOCAL-PEERS

| Settings | Value |
| -------- | ----- |
| Address Family | evpn |
| Remote AS | 65000 |
| Source | Loopback0 |
| BFD | True |
| Send community | all |
| Maximum routes | 0 (no limit) |

#### MLAG-IPv4-UNDERLAY-PEER

| Settings | Value |
| -------- | ----- |
| Address Family | ipv4 |
| Remote AS | 65000 |
| Next-hop self | True |
| Send community | all |
| Maximum routes | 12000 |

### BGP Neighbors

| Neighbor | Remote AS | VRF | Shutdown | Send-community | Maximum-routes | Allowas-in | BFD | RIB Pre-Policy Retain | Route-Reflector Client |
| -------- | --------- | --- | -------- | -------------- | -------------- | ---------- | --- | --------------------- | ---------------------- |
| 1.1.1.1 | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | default | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | - | - |
| 1.1.1.2 | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | default | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | - | - |
| 192.2.2.29 | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | CORP | - | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | Inherited from peer group MLAG-IPv4-UNDERLAY-PEER | - | - | - | - |

### Router BGP EVPN Address Family

- VPN import pruning is __enabled__

#### EVPN Peer Groups

| Peer Group | Activate |
| ---------- | -------- |
| EVPN-OVERLAY-LOCAL-PEERS | True |

### Router BGP VLANs

| VLAN | Route-Distinguisher | Both Route-Target | Import Route Target | Export Route-Target | Redistribute |
| ---- | ------------------- | ----------------- | ------------------- | ------------------- | ------------ |
| 10 | 1.1.1.15:10010 | 10010:10010 | - | - | learned |
| 20 | 1.1.1.15:10020 | 10020:10020 | - | - | learned |
| 30 | 1.1.1.15:10030 | 10030:10030 | - | - | learned |
| 40 | 1.1.1.15:10040 | 10040:10040 | - | - | learned |
| 50 | 1.1.1.15:10050 | 10050:10050 | - | - | learned |

### Router BGP VRFs

| VRF | Route-Distinguisher | Redistribute |
| --- | ------------------- | ------------ |
| CORP | 1.1.1.15:50001 | connected |

### Router BGP Device Configuration

```eos
!
router bgp 65000
   router-id 1.1.1.15
   no bgp default ipv4-unicast
   distance bgp 20 200 200
   neighbor default send-community
   graceful-restart restart-time 300
   graceful-restart
   maximum-paths 4 ecmp 4
   neighbor EVPN-OVERLAY-LOCAL-PEERS peer group
   neighbor EVPN-OVERLAY-LOCAL-PEERS remote-as 65000
   neighbor EVPN-OVERLAY-LOCAL-PEERS update-source Loopback0
   neighbor EVPN-OVERLAY-LOCAL-PEERS bfd
   neighbor EVPN-OVERLAY-LOCAL-PEERS password 7 LenMQ+SJnRMvQfwsxxnuXw==
   neighbor EVPN-OVERLAY-LOCAL-PEERS send-community
   neighbor EVPN-OVERLAY-LOCAL-PEERS maximum-routes 0
   neighbor MLAG-IPv4-UNDERLAY-PEER peer group
   neighbor MLAG-IPv4-UNDERLAY-PEER remote-as 65000
   neighbor MLAG-IPv4-UNDERLAY-PEER next-hop-self
   neighbor MLAG-IPv4-UNDERLAY-PEER description DC1-LEAF6
   neighbor MLAG-IPv4-UNDERLAY-PEER send-community
   neighbor MLAG-IPv4-UNDERLAY-PEER maximum-routes 12000
   neighbor MLAG-IPv4-UNDERLAY-PEER route-map RM-MLAG-PEER-IN in
   neighbor 1.1.1.1 peer group EVPN-OVERLAY-LOCAL-PEERS
   neighbor 1.1.1.1 description DC1-SPINE1
   neighbor 1.1.1.2 peer group EVPN-OVERLAY-LOCAL-PEERS
   neighbor 1.1.1.2 description DC1-SPINE2
   !
   vlan 10
      rd 1.1.1.15:10010
      route-target both 10010:10010
      redistribute learned
   !
   vlan 20
      rd 1.1.1.15:10020
      route-target both 10020:10020
      redistribute learned
   !
   vlan 30
      rd 1.1.1.15:10030
      route-target both 10030:10030
      redistribute learned
   !
   vlan 40
      rd 1.1.1.15:10040
      route-target both 10040:10040
      redistribute learned
   !
   vlan 50
      rd 1.1.1.15:10050
      route-target both 10050:10050
      redistribute learned
   !
   address-family evpn
      neighbor EVPN-OVERLAY-LOCAL-PEERS route-map RM-EVPN-SOO-IN in
      neighbor EVPN-OVERLAY-LOCAL-PEERS route-map RM-EVPN-SOO-OUT out
      neighbor EVPN-OVERLAY-LOCAL-PEERS activate
      route import match-failure action discard
   !
   address-family ipv4
      no neighbor EVPN-OVERLAY-LOCAL-PEERS activate
      neighbor MLAG-IPv4-UNDERLAY-PEER activate
   !
   vrf CORP
      rd 1.1.1.15:50001
      route-target import evpn 50001:50001
      route-target export evpn 50001:50001
      router-id 1.1.1.15
      neighbor 192.2.2.29 peer group MLAG-IPv4-UNDERLAY-PEER
      redistribute connected
```

# BFD

## Router BFD

### Router BFD Multihop Summary

| Interval | Minimum RX | Multiplier |
| -------- | ---------- | ---------- |
| 300 | 300 | 3 |

### Router BFD Device Configuration

```eos
!
router bfd
   multihop interval 300 min-rx 300 multiplier 3
```

# Multicast

## IP IGMP Snooping

### IP IGMP Snooping Summary

| IGMP Snooping | Fast Leave | Interface Restart Query | Proxy | Restart Query Interval | Robustness Variable |
| ------------- | ---------- | ----------------------- | ----- | ---------------------- | ------------------- |
| Enabled | - | - | - | - | - |

### IP IGMP Snooping Device Configuration

```eos
```

# Filters

## Route-maps

### Route-maps Summary

#### RM-EVPN-SOO-IN

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | deny | extcommunity ECL-EVPN-SOO | - | - | - |
| 20 | permit | - | - | - | - |

#### RM-EVPN-SOO-OUT

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | permit | - | extcommunity soo 2.2.2.15:1 additive | - | - |

#### RM-MLAG-PEER-IN

| Sequence | Type | Match | Set | Sub-Route-Map | Continue |
| -------- | ---- | ----- | --- | ------------- | -------- |
| 10 | permit | - | origin incomplete | - | - |

### Route-maps Device Configuration

```eos
!
route-map RM-EVPN-SOO-IN deny 10
   match extcommunity ECL-EVPN-SOO
!
route-map RM-EVPN-SOO-IN permit 20
!
route-map RM-EVPN-SOO-OUT permit 10
   set extcommunity soo 2.2.2.15:1 additive
!
route-map RM-MLAG-PEER-IN permit 10
   description Make routes learned over MLAG Peer-link less preferred on spines to ensure optimal routing
   set origin incomplete
```

## IP Extended Community Lists

### IP Extended Community Lists Summary

| List Name | Type | Extended Communities |
| --------- | ---- | -------------------- |
| ECL-EVPN-SOO | permit | soo 2.2.2.15:1 |

### IP Extended Community Lists configuration

```eos
!
ip extcommunity-list ECL-EVPN-SOO permit soo 2.2.2.15:1
```

# ACL

# VRF Instances

## VRF Instances Summary

| VRF Name | IP Routing |
| -------- | ---------- |
| CORP | enabled |
| MGMT | disabled |

## VRF Instances Device Configuration

```eos
!
vrf instance CORP
!
vrf instance MGMT
```

# Quality Of Service
