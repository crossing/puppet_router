class dns {
  $keygen_cmd = 'rndc-confgen -a -b 512 -k dhcpupdate -r /dev/urandom -c /etc/bind/dns-dhcp.key'

  package {'bind9':
    ensure => installed
  }
 
  exec {$keygen_cmd:    
    path => '/usr/sbin',
    creates => '/etc/bind/dns-dhcp.key',
    require => Package['bind9']
  }
  
  file {'/etc/bind/dns-dhcp.key':
    ensure => present,
    mode => 644,
    require => Exec[$keygen_cmd],
  }
  
  file {'/etc/bind/named.conf.local':
    ensure => file,
    source => 'puppet:///modules/router/etc/bind/named.conf.local',
    owner => root,
    group => bind,
    mode => 644,
    require => Package['bind9']
  }
  
  file {'/etc/bind/named.conf.options':
    ensure => file,
    source => 'puppet:///modules/router/etc/bind/named.conf.options',
    owner => root,
    group => bind,
    mode => 644,
    require => Package['bind9']
  }
  
  file {'/etc/bind/db.example.local':
    ensure => file,
    source => 'puppet:///modules/router/etc/bind/db.example.local',
    owner => root,
    group => bind,
    mode => 644,
    require => Package['bind9']
  }
  
  file {'/etc/bind/db.192':
    ensure => file,
    source => 'puppet:///modules/router/etc/bind/db.192',
    owner => root,
    group => bind,
    mode => 644,
    require => Package['bind9']
  }
  
  service {'bind9':
    ensure => running,
    enable => true,
    require => File['/etc/bind/dns-dhcp.key'],
    subscribe => [File['/etc/bind/named.conf.local'], File['/etc/bind/named.conf.options'], File['/etc/bind/db.example.local'], File['/etc/bind/db.192']]
  }
}
