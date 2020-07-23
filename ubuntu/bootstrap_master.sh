#!/bin/bash

# Initialize Kubernetes
echo "[TASK 1] Initialize Kubernetes Cluster"
kubeadm init --apiserver-advertise-address=172.16.16.10 --pod-network-cidr=192.168.0.0/16 >> $HOME/kubeinit.log

# Copy Kube admin config
echo "[TASK 2] Copy kube admin config to Vagrant user .kube directory"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


# Deploy Calico network
echo "[TASK 3] Deploy Calico network"
kubectl create -f https://docs.projectcalico.org/v3.11/manifests/calico.yaml

# Generate Cluster join command
echo "[TASK 4] Generate and save cluster join command to /joincluster.sh"
kubeadm token create --print-join-command > /tmp/joincluster.sh
