#!/bin/bash

# Create new user
user=$1
adduser --disabled-password --gecos "" $user

# Generate a random password for the new user
password=$(openssl rand -base64 12)

# Set password for the new user
echo "$user:${password}" | chpasswd

# Add a public key to the authorized keys to ssh to the machine as the user '$user'
mkdir -p /home/$user/.ssh
chown $user:$user /home/$user/.ssh
chmod 700 /home/$user/.ssh

echo "Enter Public Key"
read -s public_key 

echo "$public_key" > /home/$user/.ssh/authorized_keys
chown $user:$user /home/$user/.ssh/authorized_keys
chmod 600 /home/$user/.ssh/authorized_keys

# Print out the password
echo "Generated password for $user is: ${password}"
sudo usermod -aG docker $user
