#!/bin/bash

. ../../include/common.sh
. .envrc

helm_init

container_ip=$(minikube ip --profile "$CLUSTER_NAME")
domain="${container_ip}.$MAGICDNS"

if ! kubectl get configmap -n kube-system 2>/dev/null | grep -qi cap-values; then
    kubectl create configmap -n kube-system cap-values \
            --from-literal=public-ip="${container_ip}" \
            --from-literal=domain="$domain" \
            --from-literal=services="hardcoded" \
            --from-literal=platform="minikube"
fi
