# Class: vision_firewall::forward
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_firewall::forward
#

define vision_firewall::forward (

  String $ipaddress,
  String $dom0hostname,
  String $dom0ip,
  String $sourceip,
  String $dport,
  String $rule_name = $title

) {

  $todest = "${ipaddress}:${dport}"

  firewall { $rule_name :
      tag         => $dom0hostname,
      chain       => 'PREROUTING',
      table       => 'nat',
      proto       => 'tcp',
      iniface     => 'eth0',
      source      => $sourceip,
      destination => $dom0ip,
      jump        => 'DNAT',
      dport       => $dport,
      todest      => $todest,
  }

}
