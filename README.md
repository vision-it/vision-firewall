# vision-firewall

[![Build Status](https://travis-ci.org/vision-it/vision-firewall.svg?branch=production)](https://travis-ci.org/vision-it/vision-firewall)


## Firewall Rule Examples

Webserver:

```
vision_firewall::system_rules:
  '100 allow http and https access':
    dport: [80, 443]
    proto: 'tcp'
    action: 'accept'
```

LDAP:

```
vision_firewall::system_rules:
  '100 allow ldap access':
    dport: '389'
    proto: 'tcp'
    action: 'accept'
  '101 allow ldaps access':
    dport: 636'
    proto: 'tcp'
    action: 'accept'
```

Kerberos:

```
vision_firewall::system_rules:
  '100 allow kerberos access':
    dport: '88'
    proto: 'udp'
    action: 'accept'
```

MySQL:

```
vision_firewall::system_rules:
  '100 allow mysql access':
    dport: '3306'
    proto: 'tcp'
    action: 'accept'
```

Puppet Master:

```
vision_firewall::system_rules:
  '100 allow puppet master access':
    dport: '8140'
    proto: 'tcp'
    action: 'accept'
```


## Usage

Include in the *Puppetfile*:

```
mod vision_firewall:
    :git => 'https://github.com/vision-it/vision-firewall.git,
    :ref => 'production'
```

Include in a role/profile:

```puppet
contain ::vision_firewall
```
