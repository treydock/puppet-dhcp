# Usage #

In your node or other definitions you can use these variables

* dhcpd_authoritative - true/false if DHCPD server is authoritative
* dhcpd_ddns_update - String, values can be ad-hoc, interim or none
* dhcpd_opts - Array of strings
* dhcpd_pxe_only - true/false whether to allow only PXE requests and not give out DHCP to all requests

## Subnet definition ##

Here is an example of defining a subnet

```ruby
    dhcp::subnet { "10.1.0.0":
        name        => '10.1.0.0',
        netmask     => '255.255.255.0',
        range_start => '10.1.0.50',
        range_end   => '10.1.0.254',
        router      => '10.1.0.1',
        domain_name => 'domain.com',
        dns_servers => "10.1.0.254, 10.1.0.253",
        pxe_only    => true,
        pxe_opts    => 'filename "pxelinux.0";',
        pxe_next_server    => '10.1.0.4',
    }
```

## static IP definition ##

This parameter is designed to be added to node defintions, but can also be used with an ENC (see comment in manifests/hosts.pp)

```ruby
$dhcp_hosts = {
	'client_hostname' => {
		ip	=> '10.1.0.49',
		mac	=> '00:00:00:00:00:00',
	},
	'client_hostname2' => {
		ip	=> '10.1.0.48',
		mac	=> '00:00:00:00:00:01',
	},
}
	
```


# Example #

```ruby

node 'fog_server' {
    $dhcpd_authoritative = true
    $dhcpd_ddns_update = "interim"
    $dhcpd_opts = [ 'use-host-decl-names on', 'ignore client-updates;' ]
    $dhcpd_pxe_only = true

    include dhcp

    dhcp::subnet { "10.1.0.0":
        netmask     => '255.255.255.0',
        range_start => '10.1.0.50',
        range_end   => '10.1.0.254',
        router      => '10.1.0.1',
        domain_name => 'domain.com',
        dns_servers => "10.1.0.254, 10.1.0.253",
        pxe_only    => true,
        pxe_opts    => 'filename "pxelinux.0";',
        pxe_next_server    => '10.1.0.4',;

     		"10.1.1.0":
        netmask     => '255.255.255.0',
        range_start => '10.1.1.50',
        range_end   => '10.1.1.254',
        router      => '10.1.1.1',
        domain_name => 'domain.com',
        dns_servers => "10.1.0.254, 10.1.0.253",
        pxe_only    => true,
        pxe_opts    => 'filename "pxelinux.0";',
        pxe_next_server    => '10.1.0.4',;
    }
}
```

For complete list of available options to use in dhcpd.conf see http://linux.die.net/man/5/dhcpd.conf


Requires: https://github.com/ripienaar/puppet-concat
