.. _overview:

Document purpose
================

This document provides instructions for installing, configuring and using
Neutron Firewall-as-a-Service plugin for Fuel.


Key terms, acronyms and abbreviations
-------------------------------------

+----------------------------+------------------------------------------------+
| Term/abbreviation          | Definition                                     |
+============================+================================================+
| VPNaaS                     | VPN-as-a-Service. Neutron extension used to    |
|                            | connect 2 private networks via Internet.       |
+----------------------------+------------------------------------------------+
| IPSec                      | Internet Protocol Security (IPsec) is a        |
|                            | protocol suite for securing Internet Protocol  |
|                            | (IP) communications by authenticating and      |
|                            | encrypting each IP packet of a communication   |
|                            | session.                                       |
+----------------------------+------------------------------------------------+
| OpenSwan                   | An IPsec implementation for Linux. It has      |
|                            | support for most of the extensions (RFC + IETF |
|                            | drafts) related to IPsec, including IKEv2,     |
|                            | X.509 Digital Certificates, NAT Traversal, and |
|                            | many others.                                   |
+----------------------------+------------------------------------------------+
| IKE                        | Internet Key Exchange is the protocol used to  |
|                            | set up a security association (SA) in the IPsec|
|                            | protocol suit.                                 |
+----------------------------+------------------------------------------------+
| VM                         | Virtual Machine (Instance)                     |
+----------------------------+------------------------------------------------+


VPNaaS Plugin
-------------

VPNaaS (VPN-as-a-Service) Fuel plugin provides an opportunity to deploy and
configure a VPNaaS Neutron extension. VPNaaS Neutron extension introduces VPN
feature set in Neutron which is based on Openswan (opensource IPSec
implementation). The main goal is to provide VPN connection as a service
between 2 private networks over the public network (in general via Internet).

That means, you can build a VPN connection between 2 private subnets, which can
be placed in 2 different tenants and separate OpenStack clouds — for example,
premise and hosted clouds in a hybrid application.


Requirements
------------


+----------------------------+------------------------------------------------+
| Requirement                | Version/Comment                                |
+============================+================================================+
| Fuel                       | 7.0 release                                    |
+----------------------------+------------------------------------------------+
| OpenStack compatibility    | 2015.1 Kilo                                    |
+----------------------------+------------------------------------------------+
| Operating systems          | Ubuntu 14.04 LTS                               |
+----------------------------+------------------------------------------------+


Limitations
-----------

VPNaaS plugin can be enabled only in environments with Neutron with ML2 plugin
with OpenVSwitch Mechanism driver (default configuration) as the networking
option and tested only with the OpenSwan driver.


Known issues
------------

* `[VPNaaS] Active VPN connection goes down after controller shutdown/start`_


.. target-notes::
.. _[VPNaaS] Active VPN connection goes down after controller shutdown/start: https://bugs.launchpad.net/mos/+bug/1500876

