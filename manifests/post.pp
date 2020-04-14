# Class: vision_firewall::post
# ===========================
#
# This class gets applied after all Firewall rules are in place
#

class vision_firewall::post {

  firewall { '999 drop all other requests':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }

}
