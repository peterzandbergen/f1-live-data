#!/bin/bash

source $(dirname $0)/settings.env

kind delete cluster --name $CLUSTER_NAME