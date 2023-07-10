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

function check_package_installed () {
	#echo "Checking $1 package installed"
	if ! $(which $1 &> /dev/null) ; then
		echo "ERROR: '$1' package is not installed"
		exit 1
	fi
}

function internet_connection_test () {
	echo "INTERNET CONNECTION TEST"

    echo -n "  IPv4 Internet: "
	# Using Google and Cloudflare IPv4 DNS IP addresses for test
	if $(ping -4 -c 1 8.8.8.8 &> /dev/null) || $(ping -4 -c 1 1.1.1.1 &> /dev/null) ; then
		ipv4_internet="AVAILABLE"
	else
		ipv4_internet="UNAVAILABLE"
	fi
	echo "$ipv4_internet"

    echo -n "  IPv6 Internet: "
	# Using Google and Cloudflare IPv6 DNS IP addresses for test
	if $(ping -6 -c 1 2001:4860:4860::8888 &> /dev/null) || $(ping -6 -c 1 2606:4700:4700::1111 &> /dev/null) ; then
		ipv6_internet="AVAILABLE"
	else
		ipv6_internet="UNAVAILABLE"
	fi
	echo "$ipv6_internet"

	echo -n "  INTERNET ACCESS: "
    if [ "$ipv4_internet" == "UNAVAILABLE" ] && [ "$ipv6_internet" == "UNAVAILABLE" ]; then
		internet_connection_result[0]="UNAVAILABLE"
	elif [ "$ipv4_internet" == "AVAILABLE" ] || [ "$ipv6_internet" == "AVAILABLE" ]; then
		internet_connection_result[0]="AVAILABLE"
		if [ "$ipv4_internet" == "AVAILABLE" ]; then
			internet_connection_result[1]="IPv4"
		fi
		if [ "$ipv6_internet" == "AVAILABLE" ]; then
			internet_connection_result[2]="IPv6"
		fi
	fi
	echo "${internet_connection_result[0]} ${internet_connection_result[1]} ${internet_connection_result[2]}"

	# excluding unnecessary variables
	unset ipv4_internet ipv6_internet

	# variable "internet_connection_result" contains resume of this function
	# ${internet_connection_result[0]} is result, "AVAILABLE" OR "UNAVAILABLE"
	# ${internet_connection_result[1]} is "IPv4" if available
	# ${internet_connection_result[2]} is "IPv6" if available
}

function name_resolution_test () {
	echo "NAME RESOLUTION TEST"

	echo -n "  Resolution Name: "
	if $(dig +short google.com &> /dev/null) || $(dig +short nic.br &> /dev/null) ; then
		name_resolution_result="SUCCESS"
	else
		name_resolution_result="ERROR"
	fi
	echo "$name_resolution_result"
	# variable "name_resolution_result" contains resume of this function
	# $name_resolution_result is result, "SUCCESS" OR "ERROR"
}

function my_public_ip_identification () {
	echo "MY PUBLIC IP IDENTIFICATION"

	# check if internet connection is tested
	if [ -z "$internet_connection_result" ]; then
		echo "Internet connection not teinternet_connection_resultsted before"
		internet_connection_test
	fi

	# check if name resolution is tested
	if [ -z "$name_resolution_result" ]; then
		echo "Name resolution not tested before"
		name_resolution_test
	fi

	# set default values of variables
	my_public_ip[0]="unknown"
	my_public_ip[1]="unknown"

	# Discovering My Public IPv4
	if [ -n "${internet_connection_result[1]}" ]; then
		my_public_ipv4=$(curl -4 -s https://api.ipify.org)
		if [ -n "$my_public_ipv4" ]; then
			my_public_ip[0]="$my_public_ipv4"
		fi
		unset my_public_ipv4
		echo "  IPv4: ${my_public_ip[0]}"
	fi

	# Discovering my public IPv6
	if [ -n "${internet_connection_result[2]}" ]; then
		my_public_ipv6=$(curl -6 -s https://api6.ipify.org)
		if [ -n "$my_public_ipv6" ]; then
			my_public_ip[1]="$my_public_ipv6"
		fi
		unset my_public_ipv6
		echo "  IPv6: ${my_public_ip[1]}"
	fi

	# variable "my_public_ip" contains resume of this function
	# ${my_public_ip[0]}" is the IPv4 address, if available
	# ${my_public_ip[1]}" is the IPv6 address, if available
}

check_package_installed curl
internet_connection_test
name_resolution_test
my_public_ip_identification
