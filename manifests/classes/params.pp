/*

= Class: dhcp::params
Do NOT include this class - it won't do anything.
Set variables for names and paths

*/
class dhcp::params {
	
	case $operatingsystem {
    	CentOS: {
    		$dhcp_config_dir = $operatingsystemrelease? {
        		5.6 => "/etc/dhcp",
      		}
		}
	}
}
