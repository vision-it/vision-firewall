# Class: vision_firewall
# ===========================
#
# Parameters
# ----------
#
# @param ignore_purge List of rules to ignore when purging
# @param forward_policy Policy for forward table
# @param system_rules List of rules to apply. See README
#

class vision_firewall (

  Array $ignore_purge,
  String $forward_policy,
  Optional[Hash] $system_rules  = undef,

) {

  Firewall {
    before  => Class['vision_firewall::post'],
    require => Class['vision_firewall::pre'],
  }

  # Default Rules that are always applied
  contain vision_firewall::pre
  contain vision_firewall::post

  # Include firewall module
  contain ::firewall

  if ($system_rules) {
    create_resources('firewall', $system_rules)
  }

}
