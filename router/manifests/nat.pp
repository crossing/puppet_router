class nat {
  file {'/etc/init.d/nat.sh':
    ensure => file,
    source => 'puppet:///modules/router/etc/init.d/nat.sh',
    owner => root,
    group => root,
    mode => 755,
  }

  exec {'/usr/sbin/update-rc.d nat.sh defaults 99':
    subscribe => File['/etc/init.d/nat.sh']
  }
  
  exec {'/etc/init.d/nat.sh':
    subscribe => File['/etc/init.d/nat.sh']
  }
}
