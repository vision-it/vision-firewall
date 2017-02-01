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

  Optional[Hash] $system_rules  = undef,
  Optional[Hash] $export_rules  = undef,
  Optional[Array] $collect_tags = [ $::fqdn ],

) {

  # Default Rules that are always applied
  contain vision_firewall::pre
  contain vision_firewall::post

  # Include firewall module
  contain ::firewall

  if ($export_rules) {
    create_resources('@@firewall', $export_rules)
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
