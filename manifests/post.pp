# Class: vision_firewall::post
# ===========================
#
# This class gets applied after all Firewall rules are in place
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_firewall::post
#

class vision_firewall::post {

  firewall { '999 drop all other requests':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }

}
