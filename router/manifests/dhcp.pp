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
  
  service {'isc-dhcp-server':
    ensure => running,
    enable => true,
    subscribe => [File['/etc/dhcp/dhcpd.conf'], File['/etc/default/isc-dhcp-server']]
  }
}
