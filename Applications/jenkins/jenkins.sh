#! /bin/bash
kubectl create -f jenkins_ns.yaml
kubectl create -f jenkins_deployment.yaml --namespace jenkins
kubectl get pods -n jenkins -o wide
kubectl create -f jenkins_service.yaml --namespace jenkins
kubectl get services --namespace jenkins
