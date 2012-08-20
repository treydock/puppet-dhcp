define dhcp::subnet (
  	$netmask=false,
	$range_start=false,
	$range_end=false,
  	$router=false,
	$domain_name=false,
	$dns_servers=false,
	$pxe_only=false,
  	$pxe_opts=false,
	$pxe_next_server=false) {

	include dhcp::params

	concat::fragment {"dhcp.subnet.${name}":
		target => "${dhcp::params::dhcp_config_dir}/dhcpd.conf",
		order => 20,
    		content => "include \"${dhcp::params::dhcp_config_dir}/subnets/${name}.conf\";\n",
  	}

	file {"${dhcp::params::dhcp_config_dir}/subnets/${name}.conf":
	    	ensure 	=> present,
	    	owner  	=> 'root',
	    	group  	=> 'root',
	    	content => template("dhcp/subnet_conf.erb"),
	    	notify  => Service["dhcpd"],
  	}
}

