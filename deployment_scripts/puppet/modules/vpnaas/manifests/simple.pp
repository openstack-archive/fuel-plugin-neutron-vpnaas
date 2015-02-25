#This class deploys VPNaaS in simple mode.

class vpnaas::simple {

  class {'vpnaas::agent':}
  class {'vpnaas::common':}

  service { 'disable-neutron-l3-service':
    ensure  => stopped,
    name    => "neutron-l3-agent",
    enable  => false,
  }

  Service['disable-neutron-l3-service'] -> Class['vpnaas::agent'] -> Class['vpnaas::common']
}
