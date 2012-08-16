$dhcpd_authoritative = true
$dhcpd_ddns_update = "interim"
$dhcpd_opts = [ 'use-host-decl-names on', 'ignore client-updates;' ]
$dhcpd_pxe_only = true

include dhcp

dhcp::subnet { "10.0.2.0":
        netmask     => '255.255.255.0',
        range_start => '10.0.2.50',
        range_end   => '10.0.2.99',
        router      => '10.0.2.254',
        domain_name => 'domain.com',
        dns_servers => "10.0.2.10,10.0.2.11",
        pxe_only    => false,
        pxe_opts    => 'filename "pxelinux.0";',
    }
