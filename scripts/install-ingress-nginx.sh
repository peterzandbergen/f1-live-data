#!/bin/bash

# Install nginx ingress on the current cluster
# The cluster needs to have load balancer support

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# Wait for ingress to be ready
echo Waiting for ingress to be ready
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

# Patch the service type
kubectl patch --namespace ingress-nginx --patch '{"spec":{"type": "LoadBalancer"}}' svc/ingress-nginx-controller