---
title: r-fairdist
description: Fair Resource Distribution Algorithm
licenses:
  - Apache Software License 2.0
  - Lesser General Public License 2.1+
---
The *r-fairdist* project implements an algorithm to share a dynamic set of
resources fairly with a dynamic set of peers. For any given finite resource, it
provides a way to request shares of this resource and thus distribute the
resource amongst users. It tries to maximize the amount each user gets, while
retaining a reserve so any further user joining the system is always guaranteed
a specific share of the total. This guarantee keeps the system fair and
prevents malicious allocations from exploiting the resource pool.

## Example

WIP
