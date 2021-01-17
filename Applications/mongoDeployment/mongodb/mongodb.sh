#!/bin/bash

kubectl apply -f mongodb_ns.yaml
kubectl apply -f mongoDB_secret.yaml --namespace mongo-deployment
kubectl apply -f mongoDB_deployment.yaml --namespace mongo-deployment 
kubectl apply -f mongoDB_ClusterIP_SVC.yaml --namespace mongo-deployment

kubectl get all --namespace mongo-deployment
