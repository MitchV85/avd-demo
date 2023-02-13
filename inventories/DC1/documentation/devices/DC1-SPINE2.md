# DC1-SPINE2
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
- [LLDP](#lldp)
  - [LLDP Summary](#lldp-summary)
  - [LLDP Device Configuration](#lldp-device-configuration)
- [Spanning Tree](#spanning-tree)
  - [Spanning Tree Summary](#spanning-tree-summary)
  - [Spanning Tree Device Configuration](#spanning-tree-device-configuration)
- [Internal VLAN Allocation Policy](#internal-vlan-allocation-policy)
  - [Internal VLAN Allocation Policy Summary](#internal-vlan-allocation-policy-summary)
  - [Internal VLAN Allocation Policy Configuration](#internal-vlan-allocation-policy-configuration)
- [MAC Address Table](#mac-address-table)
  - [MAC Address Table Summary](#mac-address-table-summary)
  - [MAC Address Table Device Configuration](#mac-address-table-device-configuration)
- [Interfaces](#interfaces)
  - [Switchport Default](#switchport-default)
  - [Ethernet Interfaces](#ethernet-interfaces)
  - [Loopback Interfaces](#loopback-interfaces)
- [Routing](#routing)
  - [Service Routing Protocols Model](#service-routing-protocols-model)
  - [IP Routing](#ip-routing)
  - [IPv6 Routing](#ipv6-routing)
  - [Static Routes](#static-routes)
  - [ARP](#arp)
  - [Router OSPF](#router-ospf)
  - [Router BGP](#router-bgp)
- [BFD](#bfd)
  - [Router BFD](#router-bfd)
- [Multicast](#multicast)
- [Filters](#filters)
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
| Management0 | oob_management | oob | MGMT | 172.100.100.102/23 | 172.100.100.1 |

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
   ip address 172.100.100.102/23
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

STP mode: **none**

## Spanning Tree Device Configuration

```eos
!
spanning-tree mode none
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

*Inherited from Port-Channel Interface

#### IPv4

| Interface | Description | Type | Channel Group | IP Address | VRF |  MTU | Shutdown | ACL In | ACL Out |
| --------- | ----------- | -----| ------------- | ---------- | ----| ---- | -------- | ------ | ------- |
| Ethernet1 | P2P_LINK_TO_DC1-LEAF1_Ethernet2 | routed | - | 10.0.0.42/31 | default | 9214 | False | - | - |
| Ethernet2 | P2P_LINK_TO_DC1-LEAF2_Ethernet2 | routed | - | 10.0.0.46/31 | default | 9214 | False | - | - |
| Ethernet3 | P2P_LINK_TO_DC1-LEAF3_Ethernet2 | routed | - | 10.0.0.50/31 | default | 9214 | False | - | - |
| Ethernet4 | P2P_LINK_TO_DC1-LEAF4_Ethernet2 | routed | - | 10.0.0.54/31 | default | 9214 | False | - | - |
| Ethernet5 | P2P_LINK_TO_DC1-LEAF5_Ethernet2 | routed | - | 10.0.0.58/31 | default | 9214 | False | - | - |
| Ethernet6 | P2P_LINK_TO_DC1-LEAF6_Ethernet2 | routed | - | 10.0.0.62/31 | default | 9214 | False | - | - |

### Ethernet Interfaces Device Configuration

```eos
!
interface Ethernet1
   description P2P_LINK_TO_DC1-LEAF1_Ethernet2
   no shutdown
   mtu 9214
   no switchport
   ip address 10.0.0.42/31
   ip ospf network point-to-point
   ip ospf area 0.0.0.0
!
interface Ethernet2
   description P2P_LINK_TO_DC1-LEAF2_Ethernet2
   no shutdown
   mtu 9214
   no switchport
   ip address 10.0.0.46/31
   ip ospf network point-to-point
   ip ospf area 0.0.0.0
!
interface Ethernet3
   description P2P_LINK_TO_DC1-LEAF3_Ethernet2
   no shutdown
   mtu 9214
   no switchport
   ip address 10.0.0.50/31
   ip ospf network point-to-point
   ip ospf area 0.0.0.0
!
interface Ethernet4
   description P2P_LINK_TO_DC1-LEAF4_Ethernet2
   no shutdown
   mtu 9214
   no switchport
   ip address 10.0.0.54/31
   ip ospf network point-to-point
   ip ospf area 0.0.0.0
!
interface Ethernet5
   description P2P_LINK_TO_DC1-LEAF5_Ethernet2
   no shutdown
   mtu 9214
   no switchport
   ip address 10.0.0.58/31
   ip ospf network point-to-point
   ip ospf area 0.0.0.0
!
interface Ethernet6
   description P2P_LINK_TO_DC1-LEAF6_Ethernet2
   no shutdown
   mtu 9214
   no switchport
   ip address 10.0.0.62/31
   ip ospf network point-to-point
   ip ospf area 0.0.0.0
```

## Loopback Interfaces

### Loopback Interfaces Summary

#### IPv4

| Interface | Description | VRF | IP Address |
| --------- | ----------- | --- | ---------- |
| Loopback0 | EVPN_Overlay_Peering | default | 1.1.1.2/32 |

#### IPv6

| Interface | Description | VRF | IPv6 Address |
| --------- | ----------- | --- | ------------ |
| Loopback0 | EVPN_Overlay_Peering | default | - |


### Loopback Interfaces Device Configuration

```eos
!
interface Loopback0
   description EVPN_Overlay_Peering
   no shutdown
   ip address 1.1.1.2/32
   ip ospf area 0.0.0.0
```

# Routing
## Service Routing Protocols Model

Multi agent routing protocol model enabled

```eos
!
service routing protocols model multi-agent
```

## IP Routing

### IP Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | True |
| MGMT | false |

### IP Routing Device Configuration

```eos
!
ip routing
no ip routing vrf MGMT
```
## IPv6 Routing

### IPv6 Routing Summary

| VRF | Routing Enabled |
| --- | --------------- |
| default | False |
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
| 100 | 1.1.1.2 | enabled | Ethernet1 <br> Ethernet2 <br> Ethernet3 <br> Ethernet4 <br> Ethernet5 <br> Ethernet6 <br> | disabled | 12000 | disabled | disabled | - | - | - | - |

### OSPF Interfaces

| Interface | Area | Cost | Point To Point |
| -------- | -------- | -------- | -------- |
| Ethernet1 | 0.0.0.0 | - | True |
| Ethernet2 | 0.0.0.0 | - | True |
| Ethernet3 | 0.0.0.0 | - | True |
| Ethernet4 | 0.0.0.0 | - | True |
| Ethernet5 | 0.0.0.0 | - | True |
| Ethernet6 | 0.0.0.0 | - | True |
| Loopback0 | 0.0.0.0 | - | - |

### Router OSPF Device Configuration

```eos
!
router ospf 100
   router-id 1.1.1.2
   passive-interface default
   no passive-interface Ethernet1
   no passive-interface Ethernet2
   no passive-interface Ethernet3
   no passive-interface Ethernet4
   no passive-interface Ethernet5
   no passive-interface Ethernet6
   max-lsa 12000
```

## Router BGP

### Router BGP Summary

| BGP AS | Router ID |
| ------ | --------- |
| 65000|  1.1.1.2 |

| BGP AS | Cluster ID |
| ------ | --------- |
| 65000|  1.1.1.2 |

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
| Route Reflector Client | Yes |
| Source | Loopback0 |
| BFD | True |
| Send community | all |
| Maximum routes | 0 (no limit) |

### BGP Neighbors

| Neighbor | Remote AS | VRF | Shutdown | Send-community | Maximum-routes | Allowas-in | BFD | RIB Pre-Policy Retain | Route-Reflector Client |
| -------- | --------- | --- | -------- | -------------- | -------------- | ---------- | --- | --------------------- | ---------------------- |
| 1.1.1.11 | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | default | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS |
| 1.1.1.12 | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | default | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS |
| 1.1.1.13 | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | default | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS |
| 1.1.1.14 | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | default | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS |
| 1.1.1.15 | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | default | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS |
| 1.1.1.16 | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | default | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS | - | Inherited from peer group EVPN-OVERLAY-LOCAL-PEERS |

### Router BGP EVPN Address Family

#### EVPN Peer Groups

| Peer Group | Activate |
| ---------- | -------- |
| EVPN-OVERLAY-LOCAL-PEERS | True |

### Router BGP Device Configuration

```eos
!
router bgp 65000
   router-id 1.1.1.2
   bgp cluster-id 1.1.1.2
   no bgp default ipv4-unicast
   distance bgp 20 200 200
   neighbor default send-community
   graceful-restart restart-time 300
   graceful-restart
   maximum-paths 4 ecmp 4
   neighbor EVPN-OVERLAY-LOCAL-PEERS peer group
   neighbor EVPN-OVERLAY-LOCAL-PEERS remote-as 65000
   neighbor EVPN-OVERLAY-LOCAL-PEERS update-source Loopback0
   neighbor EVPN-OVERLAY-LOCAL-PEERS route-reflector-client
   neighbor EVPN-OVERLAY-LOCAL-PEERS bfd
   neighbor EVPN-OVERLAY-LOCAL-PEERS password 7 LenMQ+SJnRMvQfwsxxnuXw==
   neighbor EVPN-OVERLAY-LOCAL-PEERS send-community
   neighbor EVPN-OVERLAY-LOCAL-PEERS maximum-routes 0
   neighbor 1.1.1.11 peer group EVPN-OVERLAY-LOCAL-PEERS
   neighbor 1.1.1.11 description DC1-LEAF1
   neighbor 1.1.1.12 peer group EVPN-OVERLAY-LOCAL-PEERS
   neighbor 1.1.1.12 description DC1-LEAF2
   neighbor 1.1.1.13 peer group EVPN-OVERLAY-LOCAL-PEERS
   neighbor 1.1.1.13 description DC1-LEAF3
   neighbor 1.1.1.14 peer group EVPN-OVERLAY-LOCAL-PEERS
   neighbor 1.1.1.14 description DC1-LEAF4
   neighbor 1.1.1.15 peer group EVPN-OVERLAY-LOCAL-PEERS
   neighbor 1.1.1.15 description DC1-LEAF5
   neighbor 1.1.1.16 peer group EVPN-OVERLAY-LOCAL-PEERS
   neighbor 1.1.1.16 description DC1-LEAF6
   !
   address-family evpn
      neighbor EVPN-OVERLAY-LOCAL-PEERS activate
   !
   address-family ipv4
      no neighbor EVPN-OVERLAY-LOCAL-PEERS activate
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

# Filters

# ACL

# VRF Instances

## VRF Instances Summary

| VRF Name | IP Routing |
| -------- | ---------- |
| MGMT | disabled |

## VRF Instances Device Configuration

```eos
!
vrf instance MGMT
```

# Quality Of Service
