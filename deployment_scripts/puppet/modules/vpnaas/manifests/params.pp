#    Copyright 2015 Mirantis, Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
#
#
#
#This class contains necessary parameters for all other manifests

class vpnaas::params {

  if($::osfamily == 'Redhat') {

    $server_package        = 'openstack-neutron'

    $vpnaas_agent_package  = 'openstack-neutron-vpn-agent'

    $dashboard_package     = 'openstack-dashboard'
    $dashboard_service     = 'httpd'
    $dashboard_settings    = '/etc/openstack-dashboard/local_settings'

  } elsif($::osfamily == 'Debian') {

    $server_package        = 'neutron-server'

    $vpnaas_agent_package  = 'neutron-vpn-agent'

    $dashboard_package     = 'python-django-horizon'
    $dashboard_service     = 'apache2'
    $dashboard_settings    = '/etc/openstack-dashboard/local_settings.py'

  } else {

    fail("Unsupported osfamily ${::osfamily}")

  }

  $ipsec_service        = 'ipsec'
  $server_service       = 'neutron-server'
  $vpnaas_agent_service = 'neutron-vpn-agent'

  $openswan_package     = 'openswan'

  $vpn_agent_ocf_file   = '/usr/lib/ocf/resource.d/fuel/ocf-neutron-vpn-agent'
  $cleanup_script_file  = '/etc/puppet/modules/cluster/files/q-agent-cleanup.py'
}
