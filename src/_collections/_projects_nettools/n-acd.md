---
title: n-acd
description: IPv4 Address Conflict Detection
licenses:
  - Apache Software License 2.0
  - Lesser General Public License 2.1+
---
The *n-acd* project implements the *IPv4 Address Conflict Detection* standard
as defined in *RFC-5227*. The state machine is implemented in a shared library
and provides a stable *ISO-C11* API. The implementation is linux-only and
relies heavily on the API behavior of recent linux kernel releases.
