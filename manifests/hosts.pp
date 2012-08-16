class dhcp::hosts {
	include dhcp::params
	include concat::setup

	$dhcp_hosts_config_dir	= "${dhcp::params::dhcp_hosts_config_dir}"
	$dhcp_hosts_conf			= "${dhcp::params::dhcp_hosts_conf}"

	file { "${dhcp_hosts_config_dir}":
		ensure	=> directory,
		owner	=> 'root',
		group	=> 'root',
		mode	=> '755',
		require	=> File["${dhcp::params::dhcp_config_dir}"],
	}

#  use concat::fragment to add include line to dhcpd.conf rather than statically set path
	concat {"${dhcp_hosts_conf}":
    	owner  	=> 'root',
    	group  	=> 'root',
		mode	=> '644',
		require	=> File["${dhcp_hosts_config_dir}"],
		notify	=> [ Service['dhcpd'] ],
  	}

	concat::fragment { "dhcp-hosts-static-conf":
		target	=> "${dhcp_hosts_conf}",
		content	=> template('dhcp/hosts_static_conf.erb'),
		order	=> 01,
	}

	if $dhcp_hosts {
		# NOTE: You can use string2hash to send the dhcp_hosts parameter as a json formatted string
		# See https://github.com/treydock/puppet-string2hash
		#$hosts = string2hash($dhcp_hosts)

		create_resources('dhcp::host', $dhcp_hosts)
	}

}

