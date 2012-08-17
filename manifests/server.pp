class dhcp::server {
	include dhcp::params
	include dhcp::hosts

  	package {"dhcp":
    	ensure => present,
	}

	service {"dhcpd":
    	ensure  => running,
    	enable  => true,
    	require => Package["dhcp"],
  	}
	file {"${dhcp::params::dhcp_config_dir}":
		ensure	=> directory,
		#source	=> 'puppet:///modules/dhcp/empty',
		#recurse	=> true,
		#purge	=> true,
		owner	=> 'root',
		group	=> 'root',
		mode	=> '755',
		notify 	=> Service['dhcpd'],
		require	=> Package['dhcp'],
	}
	
	file {"${dhcp::params::dhcp_config_dir}/subnets":
		ensure	=> directory,
		#source	=> 'puppet:///modules/dhcp/empty',
		recurse	=> true,
		purge	=> true,
		owner	=> 'root',
		group	=> 'root',
		mode	=> '755',
		notify 	=> Service['dhcpd'],
		require	=> File["${dhcp::params::dhcp_config_dir}"],
	}
	
	concat {"${dhcp::params::dhcp_config_dir}/dhcpd.conf":
	    	require => Package["dhcp"],
	    	notify  => Service["dhcpd"],
	}
		

	concat::fragment {"dhcpd.conf.base":
		target => "${dhcp::params::dhcp_config_dir}/dhcpd.conf",
		order => 10,
	    	content => template("dhcp/dhcpd_conf.erb"),
  	}

}
