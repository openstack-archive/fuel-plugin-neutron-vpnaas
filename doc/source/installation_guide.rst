.. _installation:

Installation Guide
-------------------

Installing VPNaaS plugin
++++++++++++++++++++++++


#. Download the plug­in from `Fuel Plugins Catalog`_.

#. Copy the plug­in on already installed Fuel Master node::

      [user@home ~]$ scp vpnaas-plugin-1.2-1.2.0-1.noarch.rpm root@:/
      <the_Fuel_Master_node_IP>:~/

#. Log into the Fuel Master node. Install the plugin::

      [root@fuel ~]# fuel plugins --install vpnaas-plugin-1.2-1.2.0-1.noarch.rpm

#. Verify that the plugin is installed correctly::

      [root@fuel ~]# fuel plugins --list
      id | name          | version | package_version
      ---|---------------|---------|----------------
      1  | vpnaas_plugin | 1.2.0   | 2.0.0


Creating Environment with VPNaaS
++++++++++++++++++++++++++++++++

#. After plug­in is installed, create a new OpenStack environment with Neutron.

#. `Configure your environment`_.

#. Open the Settings tab of the Fuel web UI and scroll down the page. Select
   VPNaaS plugin checkbox:

   .. image:: _static/vpnaas_in_fuel_ui.png

#. `Deploy your environment`_.


**********
References
**********

.. target-notes::
.. _Fuel Plugins Catalog: https://software.mirantis.com/download-mirantis-openstack-fuel-plug-ins
.. _Configure your environment: http://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#configure-your-environment
.. _Deploy your environment: http://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#deploy-changes
