# Class: vision_firewall::rule
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_firewall::rule
#

define vision_firewall::rule (

  String $dport,
  String $sourceip     = '0.0.0.0',
  String $ipaddress    = $::ipaddress,
  String $tag          = $::dom0hostname,
  String $dest         = $::dom0ip,
  String $rule_name    = $title,
  String $interface    = 'eth0',
  String $protocol     = 'tcp',
  String $chain        = 'PREROUTING',
  String $table        = 'nat',

) {

  $todest = "${ipaddress}:${dport}"

  if $sourceip == '0.0.0.0' {

    firewall { $rule_name :
      tag         => $tag,
      chain       => $chain,
      table       => $table,
      proto       => $protocol,
      iniface     => $interface,
      destination => $dest,
      jump        => 'DNAT',
      dport       => $dport,
      todest      => $todest,
    }
  } else {

    firewall { $rule_name :
      tag         => $tag,
      chain       => $chain,
      table       => $table,
      proto       => $protocol,
      iniface     => $interface,
      source      => $sourceip,
      destination => $dest,
      jump        => 'DNAT',
      dport       => $dport,
      todest      => $todest,
    }
  }

}
