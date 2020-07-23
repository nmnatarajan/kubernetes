#!/bin/bash
# Join worker nodes to the Kubernetes cluster
echo "[TASK 1] Join node to Kubernetes Cluster"
apt-get install -q -y sshpass
sshpass -p "vagrant" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no vagrant@master.example.com:/tmp/joincluster.sh /tmp/joincluster.sh 
sudo chmod a+X /tmp/joincluster.sh
sudo bash /tmp/joincluster.sh > joincluster.log
echo "DONE"