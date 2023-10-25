#!/bin/bash
user=$1
# Give the user '$user' sudo privileges without having to type a password
echo "$user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
