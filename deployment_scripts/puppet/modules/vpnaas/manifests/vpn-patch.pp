
class patch-common {
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
}


class vpn-patch::vpn-agent {

  require patch-common

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
}


class vpn-patch::dashboard {

  require patch-common

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
