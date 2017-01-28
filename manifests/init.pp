# Class: vision_firewall
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_firewall
#

class vision_firewall (

  Hash $default_rules,
  Optional[Hash] $system_rules  = undef,
  Optional[Hash] $export_rules  = undef,
  Optional[Array] $collect_tags = [ $::fqdn ],
  String $location              = $::location,

) {

  # Default Rules that are always applied
  contain vision_firewall::pre
  contain vision_firewall::post

  # TODO Test if required, or already in Module
  package {'iptables-persistent':
    ensure => present,
  }

  if ($export_rules) {
    create_resources('@@vision_firewall::rule', $export_rules)
  }

  if ($system_rules) {
    create_resources('vision_firewall::rule', $system_rules)
  }

  if ($collect_tags) {
    $collect_tags.each | $tag | {
      Firewall <<| tag == $tag |>>
    }
  }

}
