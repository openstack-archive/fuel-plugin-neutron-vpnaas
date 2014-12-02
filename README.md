VPNaaS plugin
============

VPNaaS (VPN-as-a-Service) is a Neutron extension that introduces VPN feature set.

This repo contains all necessary files to build VPNaaS Fuel plugin.
Currently the only supported Fuel version is 6.0.

Building the plugin
-------------------
1. Clone the fuel-plugins repo from https://github.com/stackforge/fuel-plugins
2. Install Fuel Plugin Builder using documentation from the fuel-plugins repo
3. Execute fpb --build <path>, where <path> is the path to the plugin's main
   folder (vpnaas)
4. vpnaas-plugin-1.0.0.fp plugin file will be created
5. Move this file to the Fuel master node and install it using
   the following command: fuel plugins --install vpnaas-plugin-1.0.0.fp
6. Plugin is ready to use and can be enabled via Fuel WebUI ('Settings' tab)

Deployment details
------------------
Neutron VPN agent replaces Neutron L3 agent because it combines both L3 and
VPNaaS functionality. No user interaction is required, VPNaaS will be enabled
immediately after deployment.

Accessing VPNaaS functionality
------------------------------
VPN settings can be found in Openstack Dashboard:
Project -> Network -> VPN

Please use official Openstack documentation to obtain more information:
- https://wiki.openstack.org/wiki/Neutron/VPNaaS
