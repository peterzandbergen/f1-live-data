#!/bin/bash

# Create a kind cluster with metallb load balancer

# set -x

source $(dirname ${BASH_SOURCE[0]})/settings.env

function echo_banner() {
    echo ===================================
    echo = "$*"
    echo ===================================
}

DIR=$(dirname ${BASH_SOURCE[0]})

# Create Kind cluster
echo_banner Creating cluster using settings in $(realpath $DIR/$KIND_CONFIG)
kind create cluster --config $DIR/$KIND_CONFIG --name $CLUSTER_NAME

# Get the CIDR of kind
CIDR=$(docker network inspect -f '{{ (index .IPAM.Config 0).Subnet }}' kind)

# Strip the first two bytes
CIDR_PREFIX=$(echo -n $CIDR 2 | $DIR/cidr-n-parts.awk)

echo_banner cidr=$CIDR cidr_prefix=$CIDR_PREFIX
# read -p "press enter to continue, ctrl-c to abort"

# Install metallb
echo_banner Installing metallb
kubectl apply -f $METALLB_MANIFEST

function metallb_ready() {
    kubectl wait \
    --namespace $METALLB_NS \
    --for=condition=ready pod \
    --selector=app=metallb \
    --timeout=90s 2>&1>/dev/null
    return $?
}

echo_banner Waiting for metallb to be ready
# Wait for metallb to be ready
while ! metallb_ready
do
    sleep 3
done

echo_banner Applying the metallb ip settings
# Set the metallb ip settings
sed 's/cidr_prefix/'"$CIDR_PREFIX"'/g' $DIR/metallb-ipsettings.yaml.tpl | \
    kubectl apply -f -
