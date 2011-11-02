class adapters {
	file {'/etc/network/interfaces':
		ensure => file,
		source => "puppet:///modules/router/etc/network/interfaces",
		owner => root,
		group => root,
		mode => 644
	}
	
	file {'/etc/dhcp/dhclient.conf':
		ensure => file,
		source => "puppet:///modules/router/etc/dhcp/dhclient.conf",
		owner => root,
		group => root,
		mode => 644
	}
	
	service {'networking':
		ensure => running,
		enable => true,
		hasstatus => false,
		status => "echo 'networking is running'",
		subscribe => [File['/etc/network/interfaces'], File['/etc/dhcp/dhclient.conf']],
		require => Class['dns']
	}
}
