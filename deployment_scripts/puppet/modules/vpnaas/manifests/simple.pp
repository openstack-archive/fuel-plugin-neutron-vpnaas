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

#This class deploys VPNaaS in simple mode.

class vpnaas::simple {

  class {'vpnaas::agent':}
  class {'vpnaas::common':}

  service { 'disable-neutron-l3-service':
    ensure  => stopped,
    name    => 'neutron-l3-agent',
    enable  => false,
  }

  Service['disable-neutron-l3-service'] -> Class['vpnaas::agent'] -> Class['vpnaas::common']
}
