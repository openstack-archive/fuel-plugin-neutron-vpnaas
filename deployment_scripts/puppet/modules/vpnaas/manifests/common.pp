#This class contains common changes both for HA and simple deployment mode.
#It enables VPN tab in Horizon and setups Neutron server.

class vpnaas::common {

    include vpnaas::params

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

    exec { "enable_vpnaas_dashboard":
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

    Exec['enable_vpnaas_dashboard'] -> Ini_subsetting['add_vpnaas_service_plugin'] ~>
    Service[$vpnaas::params::server_service] ~> Service[$vpnaas::params::dashboard_service]
}
