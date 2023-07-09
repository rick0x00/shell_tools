#!/usr/bin/env bash

# ============================================================ #
# Tool Created date: 29 jul 2023                               #
# Tool Created by: Henrique Silva (rick.0x00@gmail.com)        #
# Tool Name: network_info                                      #
# Description: extract some info about network on machine      #
# License: MIT License                                         #
# Remote repository 1: https://github.com/rick0x00/shell_tools #
# Remote repository 2: https://gitlab.com/rick0x00/shell_tools #
# ============================================================ #

function internet_connection_test () {
	echo "INTERNET CONNECTION TEST"

    echo -n "IPv4 Internet: "
	# Using Google and Cloudflare IPv4 DNS IP addresses for test
	if $(ping -4 -c 1 8.8.8.8 &> /dev/null) || $(ping -4 -c 1 1.1.1.1 &> /dev/null) ; then
		ipv4_internet="AVAILABLE"
	else
		ipv4_internet="UNAVAILABLE"
	fi
	echo "$ipv4_internet"

    echo -n "IPv6 Internet: "
	# Using Google and Cloudflare IPv6 DNS IP addresses for test
	if $(ping -6 -c 1 2001:4860:4860::8888 &> /dev/null) || $(ping -6 -c 1 2606:4700:4700::1111 &> /dev/null) ; then
		ipv6_internet="AVAILABLE"
	else
		ipv6_internet="UNAVAILABLE"
	fi
	echo "$ipv6_internet"

	echo -n "INTERNET ACCESS: "
    if [ "$ipv4_internet" == "UNAVAILABLE" ] && [ "$ipv6_internet" == "UNAVAILABLE" ]; then
		echo "UNAVAILABLE"
	elif [ "$ipv4_internet" == "AVAILABLE" ] || [ "$ipv6_internet" == "AVAILABLE" ]; then
		echo -n "AVAILABLE"
		if [ "$ipv4_internet" == "AVAILABLE" ] && [ "$ipv6_internet" == "AVAILABLE" ]; then
			echo ", IPv4 AND IPv6"
		elif [ "$ipv4_internet" == "AVAILABLE" ]; then
			echo ", IPv4 Only"
		elif [ "$ipv6_internet" == "AVAILABLE" ]; then
			echo ", IPv6 Only"
		fi
	fi
}

internet_connection_test

