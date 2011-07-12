define dhcp::subnet (
	$name=false,
  	$netmask=false,
	$range_start=false,
	$range_end=false,
  	$router=false,
	$domain_name=false,
	$dns_servers=false,
	$pxe_only=false,
  	$pxe_opts=false) {

	include dhcp::params

#	common::concatfilepart {"dhcp.${name}":
#    	file => "${dhcp::params::dhcp_config_dir}/dhcpd.conf",
#    	ensure => $ensure,
#    	content => "include \"${dhcp::params::dhcp_config_dir}/subnets/${name}.conf\";\n",
#  	}

#	file {"${dhcp::params::dhcp_config_dir}/subnets/${name}.conf":
	file {"${dhcp::params::dhcp_config_dir}/subnets/10.1.0.0.conf":
    	ensure 	=> present,
    	owner  	=> 'root',
    	group  	=> 'root',
    	content => template("dhcp/subnet_conf.erb"),
    	notify  => Service["dhcpd"],
  	}
}

