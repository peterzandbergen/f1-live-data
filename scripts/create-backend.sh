#/bin/bash

DIR=$(dirname ${BASH_SOURCE[0]})

kustomize build $DIR/../kubernetes/backend | kubectl apply -f -

while ! kubectl wait --for=condition=Ready --selector=app=influxdb pod ; do echo waiting for influxdb ; sleep 1; done

while ! kubectl wait --for=condition=Ready --selector=app=grafana pod ; do echo waiting for grafana sleep 1; done

# Print the link to grafana

echo Open grafana here: http://$(kubectl get service/grafana --output=go-template --template='{{ (index .status.loadBalancer.ingress 0).ip }}'):3000

