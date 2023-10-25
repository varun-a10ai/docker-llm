#!/bin/bash
set -x
set -v
hostname=$(hostname)
interfaces=($(ifconfig -a | grep -oP '^ib.*?(?=:)'))
for i in ${interfaces[@]}; do
  sudo ip link set $i up
done

# host 1
if [ "$hostname" == "vultr" ]; then
	echo "I am host 1: $hostname"
	ip addr add 10.0.0.1 dev ibp27s0
	route add 10.0.0.2 dev ibp27s0
	route add 10.0.0.3 dev ibp27s0
fi

# host 2
if [ "$hostname" == "vultr2" ]; then
	echo "I am host 2: $hostname"
	ip addr add 10.0.0.2 dev ibp27s0
	route add 10.0.0.1 dev ibp27s0
	route add 10.0.0.3 dev ibp27s0
fi

# host 3
if [ "$hostname" == "vultr3" ]; then
	echo "I am host 3: $hostname"
	ip addr add 10.0.0.3 dev ${interfaces[0]}
	route add 10.0.0.1 dev ${interfaces[0]}
	route add 10.0.0.2 dev ${interfaces[0]}
fi

# make all users able to use infiniband
chmod -R a+rw /dev/infiniband/
