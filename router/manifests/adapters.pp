class adapters {
	file {'/etc/network/interfaces':
		ensure => file,
		source => "puppet:///modules/ntp/etc/network/interfaces"
	}
	
	service {'networking',
		ensure => running,
		enable => true,
		hasrestart => true,
		hasstatus => true,
		subscribe => File['/etc/network/interfaces']
	}
}