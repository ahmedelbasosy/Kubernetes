#!/bin/bash
echo "#Creating" $1"'s" "Keys #"

mkdir $1
cd $1

k8server=$(kubectl config view | grep server | cut -f2-4 -d":")

#Creating The Private Key#
openssl genrsa -out $1.key 2048

#Creating Certificate Signing Request#
sudo openssl req -new -key $1.key -out $1.csr -subj "/CN="$1"/O="$2

sudo cp /etc/kubernetes/pki/ca.{crt,key} .

openssl x509 -req -in $1.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out $1.crt -days 365


kubectl --kubeconfig $1.kubeconfig config set-cluster kuberenets --server $k8server  --certificate-authority ca.crt --embed-certs=true
kubectl --kubeconfig $1.kubeconfig config set-credentials $1 --client-certificate $PWD/$1.crt --client-key $PWD/$1.key --embed-certs=true
kubectl --kubeconfig $1.kubeconfig config set-context $1-kubernetes --cluster kuberenets --namespace $2 --user $1
kubectl --kubeconfig $1.kubeconfig config use-context $1-kubernetes

kubectl create ns $2
