#!/bin/bash

wget https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml


clear
echo "### Don't Forget To Edit Yaml File And Add The Below: ###"
echo "  
        - /metrics-server
        - --metric-resolution=30s
        - --kubelet-insecure-tls
        - --kubelet-preferred-address-types=InternalIP
     "
