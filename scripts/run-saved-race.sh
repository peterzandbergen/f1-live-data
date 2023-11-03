#!/bin/bash

DIR=$(dirname ${BASH_SOURCE[0]})


# Start the importer.

kustomize build $DIR/../kubernetes/dataimporter-saved | kubectl apply -f -

while ! kubectl wait --for=condition=Ready --selector app=dataimporter-saved pod ; do echo waiting for importer to be ready ; sleep 1 ; done

echo
echo Watch the race...