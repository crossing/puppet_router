class adapters {
	file {'/etc/network/interfaces':
		ensure => file,
		source => "puppet:///modules/router/etc/network/interfaces",
		owner => root,
		group => root,
		mode => 644
	}
	
	service {'networking':
		ensure => running,
		enable => true,
		subscribe => File['/etc/network/interfaces']
	}
}
