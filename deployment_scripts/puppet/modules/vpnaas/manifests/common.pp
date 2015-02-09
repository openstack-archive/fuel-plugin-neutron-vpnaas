#This class contains common changes both for HA and simple deployment mode.
#It enables VPN in Horizon and Neutron server.

class vpnaas::common {

    include vpnaas::params
    include vpn-patch::dashboard

    service { $vpnaas::params::dashboard_service:
      ensure  => running,
      enable  => true,
    }

    service { $vpnaas::params::server_service:
      ensure  => running,
      enable  => true,
    }

    service { $vpnaas::params::ipsec_service:
      ensure  => running,
      enable  => true,
    }

    exec {'enable_vpnaas_dashboard':
      command => "/bin/sed -i \"s/'enable_vpn': False/'enable_vpn': True/\" $vpnaas::params::dashboard_settings",
      unless  => "/bin/egrep \"'enable_vpn': True\" $vpnaas::params::dashboard_settings",
    }

    ini_subsetting {'add_vpnaas_service_plugin':
      ensure               => present,
      section              => 'DEFAULT',
      key_val_separator    => '=',
      path                 => '/etc/neutron/neutron.conf',
      setting              => 'service_plugins',
      subsetting           => 'neutron.services.vpn.',
      subsetting_separator => ',',
      value                => 'plugin.VPNDriverPlugin',
    }

    Class['vpn-patch::dashboard']               ~> Service[$vpnaas::params::dashboard_service]
    Exec['enable_vpnaas_dashboard']             ~> Service[$vpnaas::params::dashboard_service]
    Ini_subsetting['add_vpnaas_service_plugin'] ~> Service[$vpnaas::params::server_service]
}
