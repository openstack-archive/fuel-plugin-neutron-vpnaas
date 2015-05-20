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
