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

  Optional[Hash] $forward_rules = undef,
  String $location              = $::location,

) {

  if ($forward_rules) {

    if ($location =~ /(int|dmz)Vm/) {
      create_resources('@@vision_firewall::forward', $forward_rules)
    }

  }

}
