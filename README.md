VPNaaS plugin
=============

VPNaaS (VPN-as-a-Service) is a Neutron extension that introduces VPN feature set.

This repo contains all necessary files to build VPNaaS Fuel plugin.
Supported Fuel version is 7.0.

Building the plugin
-------------------

1. Clone the fuel-plugin repo from:

    ``git clone https://github.com/stackforge/fuel-plugin-neutron-vpnaas``

2. Install the Fuel Plugin Builder:

    ``pip install fuel-plugin-builder``

3. Build VPNaaS Fuel plugin:

   ``fpb --build fuel-plugin-neutron-vpnaas/``

4. The vpnaas-plugin-<x.x.x>.rpm plugin package will be created in the plugin folder
   (fuel-plugin-neutron-vpnaas/).

5. Move this file to the Fuel Master node with secure copy (scp):

   ``scp vpnaas-plugin-<x.x.x>.rpm root@:<the_Fuel_Master_node_IP address>:/tmp``
   ``cd /tmp``

6. Install the VPNaaS plugin:

   ``fuel plugins --install vpnaas-plugin-<x.x.x>.rpm``

6. Plugin is ready to use and can be enabled on the Settings tab of the Fuel web UI.

Note that you can also download the built VPNaaS
plugin from
the [Fuel Plugins Catalog](https://software.mirantis.com/download-mirantis-openstack-fuel-plug-ins/).

Deployment details
------------------

Neutron VPN agent replaces Neutron L3 agent
because it combines both L3 and
VPNaaS functionality. No user interaction is required,
VPNaaS will be enabled
immediately after deployment.

Currently this plugin is not compatible with Neutron DVR

Accessing VPNaaS functionality
------------------------------

VPN settings can be found in Openstack Dashboard:
Project -> Network -> VPN.

For step-by-step instructions, see [the Mirantis blogpost](https://www.mirantis.com/blog/mirantis-openstack-express-vpn-service-vpnaas-step-step/).

Please use official Openstack documentation to obtain more information:
- https://wiki.openstack.org/wiki/Neutron/VPNaaS


