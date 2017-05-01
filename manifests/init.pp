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

  Array $ignore_purge,
  String $forward_policy,
  Optional[Hash] $system_rules  = undef,
  Optional[Hash] $export_rules  = undef,
  Optional[Array] $collect_tags = [ $::fqdn ],

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

  # Somehow create_resources wont work here
  if ($export_rules) {
    $export_rules.each |$name, $rule| {
      @@Firewall{$name:
        * => $rule,
      }
    }
  }

  if ($system_rules) {
    create_resources('firewall', $system_rules)
  }

  if ($collect_tags) {
    $collect_tags.each | $tag | {
        Firewall <<| tag == $tag |>>
      }
  }

}
