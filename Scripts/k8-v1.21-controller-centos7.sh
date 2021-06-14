###### Kubernetes Controller Version 1.21 ######
## Environment: Centos/Redhat
## Creatiion Date: 09-Jun-2021
## Author: Ahmed El Basosy
################################################

###### Letting iptables see bridged traffic ######
echo "###### Letting iptables see bridged traffic ######"
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

sleep 2
clear
##########################################################

###### Checking Required Ports ######
echo "###### Checking Required Ports ######"
#Kubernetes API server
firewall-cmd --zone=public --add-port=6443/tcp --permanent
#etcd server client API
firewall-cmd --zone=public --add-port=2379-2380/tcp --permanent
#kubelet API
firewall-cmd --zone=public --add-port=10250/tcp --permanent
#kube-scheduler
firewall-cmd --zone=public --add-port=10251/tcp --permanent
#kube-controller-manager
firewall-cmd --zone=public --add-port=10252/tcp --permanent

firewall-cmd --reload

sleep 2
clear
##########################################################

###### Installing Container Runtime ######
###### Containerd ######
echo "###### installing Container Runtime: CONTAINERd ######"

cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# Setup required sysctl params, these persist across reboots.

cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# Apply sysctl params without reboot

sudo sysctl --system

sleep 2
clear

###### Installing Required Packages ######
echo "###### Installing Required Packages ######"
sudo yum install -y wget yum-utils device-mapper-persistent-data lvm2 nfs-utils
sudo yum-config-manager     --add-repo     https://download.docker.com/linux/centos/docker-ce.repo
sudo yum update -y && sudo yum install -y containerd.io

systemctl enable --now containerd

sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml

systemctl restart containerd

sleep 2
clear
##########################################################

###### Installing kubeadm, kubelet and kubectl ######
echo "###### Installing kubeadm, kubelet and kubectl ######"

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

# Set SELinux in permissive mode (effectively disabling it)

sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

# Install Kubernetes

sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
sudo yum install -y bash-completion

sudo systemctl enable --now kubelet

##########################################################
