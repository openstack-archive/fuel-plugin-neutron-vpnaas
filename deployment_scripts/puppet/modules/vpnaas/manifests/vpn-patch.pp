

class vpn-patch::vpn-agent {
  file { "${vpnaas::params::vpn_patches_dir}":
    source => "puppet:///modules/vpnaas/patches",
    recurse => true,
    mode   => 644,
    owner  => root,
    group  => root,
  }

  package { 'patch_tool':
    ensure  => installed,
    name    => 'patch',
  }

  patch { "pluto_pid":
    cwd  => $::vpnaas::params::neutron_source_path,
    patch => "neutron-pluto-pid.patch"
  }

  patch { "ipsec_mtu":
    cwd  => $::vpnaas::params::neutron_source_path,
    patch => "neutron-ipsec-template-mtu.patch",
  }

  patch { "ah_mode":
    cwd  => $::vpnaas::params::neutron_source_path,
    patch => "neutron-ah-mode-config.patch",
  }

  File["${vpnaas::params::vpn_patches_dir}"] -> Package['patch_tool'] ->
  Patch['pluto_pid'] -> Patch['ipsec_mtu'] -> Patch['ah_mode']
}


class vpn-patch::dashboard {
    patch { "only_ipsec_esp_mode":
      cwd  => $::vpnaas::params::dashboard_source_path,
      patch => "dashboard-enable-only-ipsec-esp-mode.patch",
      deep => 1,
    }
}


define patch (
  $cwd = undef,
  $patch = undef,
  $deep = 2,
) {
  exec {"${patch}":
    command   => "patch -N -p${deep} < ${vpnaas::params::vpn_patches_dir}/${patch}",
    unless    => "patch -R --dry-run -p${deep} < ${vpnaas::params::vpn_patches_dir}/${patch}",
    path      => '/usr/sbin:/usr/bin:/sbin:/bin',
    cwd       => $cwd,
  }
}
