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
}
