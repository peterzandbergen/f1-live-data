#!/bin/bash

DIR=$(dirname ${BASH_SOURCE[0]})

kubectl logs --selector app=dataimporter-live -f