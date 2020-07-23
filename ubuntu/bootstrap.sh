#!/bin/bash

# Update hosts file
echo "[TASK 1] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.16.16.10 master.example.com master
172.16.16.11 node1.example.com node1
172.16.16.12 node2.example.com node2
EOF



# Install docker from Docker-ce repository
echo "[TASK 2] Install docker container engine"
sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get install -y docker.io 

# Enable docker service
echo "[TASK 3] Enable and start docker service"
systemctl enable docker
systemctl start docker


# Add sysctl settings
echo "[TASK fix] Add sysctl settings"
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system >/dev/null 2>&1

# Disable swap
echo "[TASK 4] Disable and turn off SWAP"
sed -i '/swap/d' /etc/fstab
swapoff -a

# Add  repo file for Kubernetes
echo "[TASK 5] Add  repo file for kubernetes"
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
# Install Kubernetes
echo "[TASK 6] Install Kubernetes (kubeadm)"
sudo apt-get update 
sudo apt-get install -y kubeadm 

# Start and Enable kubelet service
echo "[TASK 7] Enable and start kubelet service"
systemctl enable kubelet
systemctl start kubelet 
systemctl status kubelet 
