#!/bin/bash

DIR=$(dirname ${BASH_SOURCE[0]})

# Run saves container

kustomize build $DIR/../kubernetes/saves-container | kubectl apply -f -

# Wait for the container to be ready.

while ! kubectl wait --for=condition=Ready pod/saves-container ; do echo waiting for saves-container; sleep 1; done

# Copy the saved race.

kubectl cp $DIR/../saves/partial_saved_data_2023_03_05.txt saves-container:/saves/save.txt

# Show the saved file.

kubectl exec -it saves-container -- ls -l /saves

# Delete the saves container.

kubectl delete pod saves-container


