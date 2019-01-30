# Overview

The Nettools Project is a reusable implementation of network configuration
standards for Linux. At its core, it provides independent libraries that
implement the most common RFCs related to network configuration and management.
On top of these, it provides services that extend these libraries, as well as
other networking resources, to provide an integrated view of all these sources
at runtime.

The Nettools Project implements standards that are at the core of network
configuration. While many of these have been around for decades, the
implementations provided by the Nettools Project focus on a few key aspects:

 * **No Policy**: Every network standard that is implemented by the Nettools
                  Project comes with a pure library implementation, that
                  provides access to the standard without placing additional
                  policies. These libraries provide networking standards that
                  are as close to the respective specifications as possible,
                  while placing limited to no restrictions on top.
                  On the contrary, these implementations are explicitly written
                  without any specific environments in mind, but allow any
                  networking manager or service to make use of them. This also
                  implies that the APIs allow full control of the protocol
                  behavior.

 * **Asynchronous**: Since network safety is crucial today, all implementations
                     and services are provided with a fully asynchronous API.
                     This allows placing their instances into isolated
                     environments, while mapping the API to an asynchronous
                     message-based interface. That is, while the libraries
                     provide in-process APIs, they are explicitly written in a
                     way that they can be mapped easily to a message-based
                     communication channel. Adopters of these libraries are
                     highly recommended to isolate execution of these protocols
                     and make use of the asynchronous API.

 * **21st Century**: Networking standards like *DHCP* and *ACD* have been
                     around for decades. Thus, they were written against
                     hardware that was obsoleted many years ago. Modern
                     hardware often no longer fits the models used in the
                     70ths. Therefore, the nettools implementations try to port
                     old standards to modern hardware, providing knobs to tune
                     parameters that no longer apply in the 21st century (no,
                     today it is no longer acceptable to wait 9s on local links
                     for address conflict detection to finish).

 * **Linux-Only**: Network configuration requires explicit knowledge of the
                   corresponding counter-parts in the kernel. While high-level
                   APIs may resemble each other across UNIX Derivatives, the
                   underlying technologies differ. The Nettools Project aligns
                   all implementations with modern Linux Kernel releases and
                   makes use of linux-only features to improve performance and
                   security of these implementations.
