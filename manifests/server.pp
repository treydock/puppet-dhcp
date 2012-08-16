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
		source	=> 'puppet:///dhcp/empty',
		recurse	=> true,
		purge	=> true,
		owner	=> 'root',
		group	=> 'root',
		mode	=> '755',
		notify 	=> Service['dhcpd'],
		require	=> Package['dhcp'],
	}
	
	file {"${dhcp::params::dhcp_config_dir}/subnets":
		ensure	=> directory,
		source	=> 'puppet:///dhcp/empty',
		recurse	=> true,
		purge	=> true,
		owner	=> 'root',
		group	=> 'root',
		mode	=> '755',
		notify 	=> Service['dhcpd'],
		require	=> File["${dhcp::params::dhcp_config_dir}"],
	}
# TODO: use concatfilepart to add include line to dhcpd.conf rather than statically set path
#	common::concatfilepart {"00.dhcp.server.base":
#    	file    => "${dhcp::params::dhcp_config_dir}/dhcpd.conf",
#    	ensure  => present,
#    	require => Package["dhcp"],
#    	notify  => Service["dhcpd"],
#  	}

	file {"${dhcp::params::dhcp_config_dir}/dhcpd.conf":
    	content => template("dhcp/dhcpd_conf.erb"),
    	ensure  => present,
    	require => Package["dhcp"],
    	notify  => Service["dhcpd"],
  	}

}
