#!/bin/bash

# Exit on error
set -e

# Variables
SFTP_GROUP="sftpusers"
SFTP_USER="sftpuser"
SFTP_PASSWORD="Sftp@1234"  # Change this to a secure password
SFTP_DIR="/sftp/$SFTP_USER"
DATA_DIR="$SFTP_DIR/data"

# Ensure the script runs as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run as root or use sudo"
    exit 1
fi

echo "Updating system and installing OpenSSH..."
yum update -y
yum install -y openssh-server

echo "Creating SFTP group: $SFTP_GROUP..."
groupadd -f $SFTP_GROUP

echo "Creating SFTP user: $SFTP_USER..."
useradd -m -s /sbin/nologin -g $SFTP_GROUP $SFTP_USER
echo "$SFTP_USER:$SFTP_PASSWORD" | chpasswd

echo "Setting up SFTP directories..."
mkdir -p "$DATA_DIR"
chown root:root /sftp
chmod 755 /sftp
chown root:root "$SFTP_DIR"
chmod 755 "$SFTP_DIR"
chown "$SFTP_USER:$SFTP_GROUP" "$DATA_DIR"
chmod 700 "$DATA_DIR"

echo "Configuring SSH for SFTP access..."
SSH_CONFIG="/etc/ssh/sshd_config"

# Backup SSH config
cp "$SSH_CONFIG" "$SSH_CONFIG.bak"

# Add SFTP configuration if not already present
if ! grep -q "Match Group $SFTP_GROUP" "$SSH_CONFIG"; then
    cat >> "$SSH_CONFIG" <<EOF

# SFTP Configuration
Match Group $SFTP_GROUP
    ChrootDirectory /sftp/%u
    ForceCommand internal-sftp
    X11Forwarding no
    AllowTcpForwarding no
EOF
fi

echo "Restarting SSH service..."
systemctl restart sshd

echo "SFTP server setup complete!"
echo "You can now connect using: sftp $SFTP_USER@your-server-ip"