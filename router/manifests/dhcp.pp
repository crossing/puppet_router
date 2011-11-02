class dhcp {
  package {'dhcp3-server':
    ensure => installed
  }
  
  file {'/etc/dhcp/dhcpd.conf':
    ensure => file,
    source => 'puppet:///modules/router/etc/dhcp/dhcpd.conf',
    owner => root,
    group => root,
    require => Package['dhcp3-server']
  }
  
  file {'/etc/default/isc-dhcp-server':
    ensure => file,
    source => 'puppet:///modules/router/etc/default/isc-dhcp-server',
    owner => root,
    group => root,
    require => Package['dhcp3-server']
  }
  
  file {'/etc/dhcp/dns-dhcp.key':
    ensure => file,
    source => '/etc/bind/dns-dhcp.key',
    require => Class['dns'],
    owner => root,
    group => root,
  }
  
  service {'isc-dhcp-server':
    ensure => running,
    enable => true,
    require => [Class["adapters"], Class["dns"]],
    subscribe => [File['/etc/dhcp/dhcpd.conf'], File['/etc/default/isc-dhcp-server'], File['/etc/dhcp/dns-dhcp.key']]
  }
}
