define dhcp::host (
	$host=$name,
  	$mac=false,
	$ip=false
) {
	include concat::setup
	include dhcp::params

	$hosts_conf			= "${dhcp::params::dhcp_hosts_conf}"

	concat::fragment { "${hosts_conf}":
		target	=> "${dhcp::params::dhcp_hosts_conf}",
		content	=> template('dhcp/hosts_conf.erb'),
		order	=> 02,
	}
}

