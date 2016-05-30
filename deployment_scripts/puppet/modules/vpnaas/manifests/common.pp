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
# == Class: vpnaas::common
#
# This class contains common changes both for HA and simple deployment mode.
# It enables VPN in Horizon and Neutron server.
#

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

    exec {'enable_vpnaas_dashboard':
      command => "/bin/sed -i \"s/'enable_vpn': False/'enable_vpn': True/\" ${vpnaas::params::dashboard_settings}",
      unless  => "/bin/egrep \"'enable_vpn': True\" ${vpnaas::params::dashboard_settings}",
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

    Exec['enable_vpnaas_dashboard']             ~> Service[$vpnaas::params::dashboard_service]
    Ini_subsetting['add_vpnaas_service_plugin'] ~> Service[$vpnaas::params::server_service]

    if $primary_controller {

      Package<| title == 'neutron-vpnaas-agent' |> -> Exec['neutron-db-sync']

      exec { 'neutron-db-sync':
        command     => 'neutron-db-manage --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugin.ini --subproject neutron-vpnaas upgrade head',
        path        => '/usr/bin',
        refreshonly => true,
        tries       => 10,
        try_sleep   => 10,
      }
      Ini_subsetting['add_vpnaas_service_plugin'] ~> Exec['neutron-db-sync']
      Exec['neutron-db-sync']                     ~> Service <| title == 'neutron-server' |>
  }
}
