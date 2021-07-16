#!/bin/bash

# Sets script to fail if any command fails.
set -e
set_xauth() {
	echo xauth add $DISPLAY . $XAUTH
	touch /root/.Xauthority
	xauth add $DISPLAY . $XAUTH
}

custom_properties() {
	echo "Custom properties"
}

run_netbeans() {
	custom_properties
	set_xauth
	echo /usr/local/netbeans-${NETBEANS_VERSION}/netbeans/bin/netbeans
	sh /usr/local/netbeans-${NETBEANS_VERSION}/netbeans/bin/netbeans
}

print_usage() {
echo "
Usage:	$0 COMMAND
Pentaho Data Integration (PDI)
Options:
  netbeans			Run netbeans (GUI)
  help		        Print this help
"
}

case "$1" in
    help)
        print_usage
        ;;
    netbeans)
	run_netbeans
        ;;
    *)
        exec "$@"
esac
