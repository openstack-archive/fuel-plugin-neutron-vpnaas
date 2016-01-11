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
# == Class: vpnaas::ha
#
# This class is intended to deploy VPNaaS in HA mode
#

class vpnaas::ha {

  include vpnaas::params
  include neutron::params

  $neutron_config     = hiera_hash('quantum_settings')

  file { $vpnaas::params::vpn_agent_ocf_file:
    mode   => '0755',
    owner  => root,
    group  => root,
    source => 'puppet:///modules/vpnaas/ocf/ocf-neutron-vpn-agent'
  }

  class {'vpnaas::common':}

  class {'vpnaas::agent':
    manage_service => true,
    enabled        => false,
  }

  if $primary_controller {
    exec {'remove_p_neutron-l3-agent':
      command => 'pcs resource delete p_neutron-l3-agent --wait=600',
      onlyif  => 'pcs resource show p_neutron-l3-agent 2>&1 > /dev/null',
      path    => '/usr/sbin:/usr/bin:/sbin:/bin',
    }
    exec {'remove_p_neutron-vpn-agent':
      command => 'pcs resource delete p_neutron-vpn-agent --wait=600',
      onlyif  => 'pcs resource show p_neutron-vpn-agent 2>&1 > /dev/null',
      path    => '/usr/sbin:/usr/bin:/sbin:/bin',
    }
    Exec['remove_p_neutron-l3-agent']  -> Cluster::Corosync::Cs_service['vpn']
    Exec['remove_p_neutron-vpn-agent'] -> Cluster::Corosync::Cs_service['vpn']
  }

  $csr_metadata        = undef
  $csr_complex_type    = 'clone'
  $csr_ms_metadata     = { 'interleave' => true }

  cluster::corosync::cs_service {'vpn':
    ocf_script      => 'ocf-neutron-vpn-agent',
    csr_parameters  => {
      'remove_artifacts_on_stop_start' => true,
    },
    csr_metadata        => $csr_metadata,
    csr_complex_type    => $csr_complex_type,
    csr_ms_metadata     => $csr_ms_metadata,
    csr_mon_intr        => '20',
    csr_mon_timeout     => '10',
    csr_timeout         => '60',
    service_name        => $neutron::params::vpnaas_agent_service,
    package_name        => $neutron::params::vpnaas_agent_package,
    service_title       => 'neutron-vpnaas-service',
    primary             => $primary_controller,
    hasrestart          => false,
  }

  File[$vpnaas::params::vpn_agent_ocf_file] -> Cluster::Corosync::Cs_service['vpn'] ->
  Class['vpnaas::common']
}
