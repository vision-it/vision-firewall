# vision-firewall

[![Build Status](https://travis-ci.org/vision-it/vision-firewall.svg?branch=production)](https://travis-ci.org/vision-it/vision-firewall)


## Parameter

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

