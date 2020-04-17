# Class: vision_firewall::psad
# ===========================
#
# Port Scan Attack Detector
#
# Parameters
# ----------
#
# @param admin_mail Mail to send alerts to
# @param hostname Hostname of the node
# @param auto_dl List of Ips to add to auto_dl (will get merged)
#

class vision_firewall::psad (

  String $admin_mail,
  Optional[Array] $auto_dl = [],
  String $hostname         = $::fqdn,

) {

  package { 'psad':
    ensure => installed,
  }

  service { 'psad':
    hasrestart => true,
    require    => Package['psad'],
  }

  file { '/etc/psad/psad.conf':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('vision_firewall/psad/psad.conf.erb'),
    notify  => Service['psad'],
  }

  file { '/etc/psad/auto_dl':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('vision_firewall/psad/auto_dl.erb'),
    notify  => Service['psad'],
  }

}
