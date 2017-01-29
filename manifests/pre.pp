# Class: vision_firewall::pre
# ===========================
#
# These are the first firewall rules applied. Default stuff.
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_firewall::pre
#

class vision_firewall::pre {

  # Default policy for chains
  firewallchain { 'INPUT:filter:IPv4':
    ensure => present,
    purge  => true,
    policy => drop,
    before => undef,
  }

  firewallchain { 'OUTPUT:filter:IPv4':
    ensure => present,
    purge  => true,
    policy => accept,
    before => undef,
  }

  firewallchain { 'FORWARD:filter:IPv4':
    ensure => present,
    purge  => true,
    policy => drop,
    before => undef,
  }

  # Sane Default Rules that are always applied first
  firewall { '000 accept all ICMP':
    proto  => 'icmp',
    action => 'accept',
    }->
  firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
    }->
  firewall { '002 reject local traffic not on loopback interface':
    iniface     => '! lo',
    proto       => 'all',
    destination => '127.0.0.1/8',
    action      => 'reject',
    }->
  firewall { '003 accept related established rules':
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
    }->
  firewall { '010 accept all SSH':
    dport  => 22,
    proto  => tcp,
    action => accept,
  }

}
