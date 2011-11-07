/*

= Class: dhcp::params
Do NOT include this class - it won't do anything.
Set variables for names and paths

*/
class dhcp::params {
	
    $dhcp_config_dir = $operatingsystem ? {
		'CentOS'	=> "/etc/dhcp",
		default		=> "/etc/dhcp",
	}
	$dhcp_hosts_config_dir		= "${dhcp_config_dir}/hosts"
	$dhcp_hosts_conf			= "${dhcp_config_dir}/hosts.conf"
}
