
class vpnaas {
  if $cluster_mode == 'ha_compact' {
    include vpnaas::ha
  } else {
    include vpnaas::simple
  }
}
