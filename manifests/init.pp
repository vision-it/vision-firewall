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

  Hash $forward_rules,
  String $location = $::location,

) {

  if ($location =~ /(int|dmz)Vm/) {
    create_resources('@@vision_firewall::forward', $forward_rules)
  }

}
