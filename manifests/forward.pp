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

  String $dport,
  String $sourceip     = '0.0.0.0',
  String $ipaddress    = $::ipaddress,
  String $dom0hostname = $::dom0hostname,
  String $dom0ip       = $::dom0ip,
  String $rule_name    = $title,

) {

  $todest = "${ipaddress}:${dport}"

  if $sourceip == '0.0.0.0' {

    firewall { $rule_name :
      tag         => $dom0hostname,
      chain       => 'PREROUTING',
      table       => 'nat',
      proto       => 'tcp',
      iniface     => 'eth0',
      destination => $dom0ip,
      jump        => 'DNAT',
      dport       => $dport,
      todest      => $todest,
    }

  } else {

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

}
