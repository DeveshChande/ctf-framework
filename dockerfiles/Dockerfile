# Use the official Ubuntu image as a base
FROM ubuntu:latest

# Install OpenSSH server and any other necessary packages
RUN apt-get update && apt-get install -y openssh-server

# Change the root password to enable quick access to container environment
RUN echo 'root:root' | chpasswd

# Create the SSH directory and set up the necessary permissions
RUN mkdir -p /run/sshd
RUN chmod 0755 /run/sshd

# Permit root login via SSH (not recommended for production)
RUN sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes\nPasswordAuthentication yes/' /etc/ssh/sshd_config

# Expose the SSH port
EXPOSE 22
