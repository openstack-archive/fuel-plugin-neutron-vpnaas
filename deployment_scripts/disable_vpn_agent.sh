#!/bin/bash

if [ -n "$(which pcs 2>/dev/null)" -a -n "$(pcs resource show p_neutron-vpn-agent 2>/dev/null)" ]; then
  pcs resource disable p_neutron-vpn-agent --wait=60
fi
