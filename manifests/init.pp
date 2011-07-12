import "classes/*.pp"
import "definitions/*.pp"

class dhcp {
	include dhcp::server
}

