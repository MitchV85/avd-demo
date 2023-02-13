# DC1_FABRIC

# Table of Contents

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

# Fabric Switches and Management IP

| POD | Type | Node | Management IP | Platform | Provisioned in CloudVision |
| --- | ---- | ---- | ------------- | -------- | -------------------------- |
| DC1_FABRIC | l3leaf | DC1-LEAF1 | 172.100.100.103/23 | cEOS | Provisioned |
| DC1_FABRIC | l3leaf | DC1-LEAF2 | 172.100.100.104/23 | cEOS | Provisioned |
| DC1_FABRIC | l3leaf | DC1-LEAF3 | 172.100.100.105/23 | cEOS | Provisioned |
| DC1_FABRIC | l3leaf | DC1-LEAF4 | 172.100.100.106/23 | cEOS | Provisioned |
| DC1_FABRIC | l3leaf | DC1-LEAF5 | 172.100.100.107/23 | cEOS | Provisioned |
| DC1_FABRIC | l3leaf | DC1-LEAF6 | 172.100.100.108/23 | cEOS | Provisioned |
| DC1_FABRIC | spine | DC1-SPINE1 | 172.100.100.101/23 | cEOS | Provisioned |
| DC1_FABRIC | spine | DC1-SPINE2 | 172.100.100.102/23 | cEOS | Provisioned |

> Provision status is based on Ansible inventory declaration and do not represent real status from CloudVision.

## Fabric Switches with inband Management IP
| POD | Type | Node | Management IP | Inband Interface |
| --- | ---- | ---- | ------------- | ---------------- |

# Fabric Topology

| Type | Node | Node Interface | Peer Type | Peer Node | Peer Interface |
| ---- | ---- | -------------- | --------- | ----------| -------------- |
| l3leaf | DC1-LEAF1 | Ethernet1 | spine | DC1-SPINE1 | Ethernet1 |
| l3leaf | DC1-LEAF1 | Ethernet2 | spine | DC1-SPINE2 | Ethernet1 |
| l3leaf | DC1-LEAF1 | Ethernet5 | mlag_peer | DC1-LEAF2 | Ethernet5 |
| l3leaf | DC1-LEAF1 | Ethernet6 | mlag_peer | DC1-LEAF2 | Ethernet6 |
| l3leaf | DC1-LEAF2 | Ethernet1 | spine | DC1-SPINE1 | Ethernet2 |
| l3leaf | DC1-LEAF2 | Ethernet2 | spine | DC1-SPINE2 | Ethernet2 |
| l3leaf | DC1-LEAF3 | Ethernet1 | spine | DC1-SPINE1 | Ethernet3 |
| l3leaf | DC1-LEAF3 | Ethernet2 | spine | DC1-SPINE2 | Ethernet3 |
| l3leaf | DC1-LEAF3 | Ethernet5 | mlag_peer | DC1-LEAF4 | Ethernet5 |
| l3leaf | DC1-LEAF3 | Ethernet6 | mlag_peer | DC1-LEAF4 | Ethernet6 |
| l3leaf | DC1-LEAF4 | Ethernet1 | spine | DC1-SPINE1 | Ethernet4 |
| l3leaf | DC1-LEAF4 | Ethernet2 | spine | DC1-SPINE2 | Ethernet4 |
| l3leaf | DC1-LEAF5 | Ethernet1 | spine | DC1-SPINE1 | Ethernet5 |
| l3leaf | DC1-LEAF5 | Ethernet2 | spine | DC1-SPINE2 | Ethernet5 |
| l3leaf | DC1-LEAF5 | Ethernet5 | mlag_peer | DC1-LEAF6 | Ethernet5 |
| l3leaf | DC1-LEAF5 | Ethernet6 | mlag_peer | DC1-LEAF6 | Ethernet6 |
| l3leaf | DC1-LEAF6 | Ethernet1 | spine | DC1-SPINE1 | Ethernet6 |
| l3leaf | DC1-LEAF6 | Ethernet2 | spine | DC1-SPINE2 | Ethernet6 |

# Fabric IP Allocation

## Fabric Point-To-Point Links

| Uplink IPv4 Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ---------------- | ------------------- | ------------------ | ------------------ |
| 10.0.0.0/23 | 512 | 24 | 4.69 % |

## Point-To-Point Links Node Allocation

| Node | Node Interface | Node IP Address | Peer Node | Peer Interface | Peer IP Address |
| ---- | -------------- | --------------- | --------- | -------------- | --------------- |
| DC1-LEAF1 | Ethernet1 | 10.0.0.41/31 | DC1-SPINE1 | Ethernet1 | 10.0.0.40/31 |
| DC1-LEAF1 | Ethernet2 | 10.0.0.43/31 | DC1-SPINE2 | Ethernet1 | 10.0.0.42/31 |
| DC1-LEAF2 | Ethernet1 | 10.0.0.45/31 | DC1-SPINE1 | Ethernet2 | 10.0.0.44/31 |
| DC1-LEAF2 | Ethernet2 | 10.0.0.47/31 | DC1-SPINE2 | Ethernet2 | 10.0.0.46/31 |
| DC1-LEAF3 | Ethernet1 | 10.0.0.49/31 | DC1-SPINE1 | Ethernet3 | 10.0.0.48/31 |
| DC1-LEAF3 | Ethernet2 | 10.0.0.51/31 | DC1-SPINE2 | Ethernet3 | 10.0.0.50/31 |
| DC1-LEAF4 | Ethernet1 | 10.0.0.53/31 | DC1-SPINE1 | Ethernet4 | 10.0.0.52/31 |
| DC1-LEAF4 | Ethernet2 | 10.0.0.55/31 | DC1-SPINE2 | Ethernet4 | 10.0.0.54/31 |
| DC1-LEAF5 | Ethernet1 | 10.0.0.57/31 | DC1-SPINE1 | Ethernet5 | 10.0.0.56/31 |
| DC1-LEAF5 | Ethernet2 | 10.0.0.59/31 | DC1-SPINE2 | Ethernet5 | 10.0.0.58/31 |
| DC1-LEAF6 | Ethernet1 | 10.0.0.61/31 | DC1-SPINE1 | Ethernet6 | 10.0.0.60/31 |
| DC1-LEAF6 | Ethernet2 | 10.0.0.63/31 | DC1-SPINE2 | Ethernet6 | 10.0.0.62/31 |

## Loopback Interfaces (BGP EVPN Peering)

| Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| ------------- | ------------------- | ------------------ | ------------------ |
| 1.1.1.0/24 | 256 | 8 | 3.13 % |

## Loopback0 Interfaces Node Allocation

| POD | Node | Loopback0 |
| --- | ---- | --------- |
| DC1_FABRIC | DC1-LEAF1 | 1.1.1.11/32 |
| DC1_FABRIC | DC1-LEAF2 | 1.1.1.12/32 |
| DC1_FABRIC | DC1-LEAF3 | 1.1.1.13/32 |
| DC1_FABRIC | DC1-LEAF4 | 1.1.1.14/32 |
| DC1_FABRIC | DC1-LEAF5 | 1.1.1.15/32 |
| DC1_FABRIC | DC1-LEAF6 | 1.1.1.16/32 |
| DC1_FABRIC | DC1-SPINE1 | 1.1.1.1/32 |
| DC1_FABRIC | DC1-SPINE2 | 1.1.1.2/32 |

## VTEP Loopback VXLAN Tunnel Source Interfaces (VTEPs Only)

| VTEP Loopback Pool | Available Addresses | Assigned addresses | Assigned Address % |
| --------------------- | ------------------- | ------------------ | ------------------ |
| 2.2.2.0/24 | 256 | 6 | 2.35 % |

## VTEP Loopback Node allocation

| POD | Node | Loopback1 |
| --- | ---- | --------- |
| DC1_FABRIC | DC1-LEAF1 | 2.2.2.11/32 |
| DC1_FABRIC | DC1-LEAF2 | 2.2.2.11/32 |
| DC1_FABRIC | DC1-LEAF3 | 2.2.2.13/32 |
| DC1_FABRIC | DC1-LEAF4 | 2.2.2.13/32 |
| DC1_FABRIC | DC1-LEAF5 | 2.2.2.15/32 |
| DC1_FABRIC | DC1-LEAF6 | 2.2.2.15/32 |
