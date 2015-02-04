VPNaaS plugin
============

VPNaaS (VPN-as-a-Service) is a Neutron extension that introduces VPN feature set.

This repo contains all necessary files to build VPNaaS Fuel plugin.
Currently the only supported Fuel versions are 6.0 and higher.

Building the plugin
-------------------
1. Clone the fuel-plugin repo from:
    git clone https://github.com/stackforge/fuel-plugin-neutron-vpnaas
2. Install Fuel Plugin Builder:
    pip install fuel-plugin-builder
3. Build VPNaaS Fuel plugin:
    fpb --build fuel-plugin-neutron-vpnaas/
4. vpnaas-plugin-x.x.x.fp plugin file will be created
5. Move this file to the Fuel master node and install
    fuel plugins --install vpnaas-plugin-x.x.x.fp
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
