#!/bin/bash

SDIR=$(dirname ${BASH_SOURCE[0]})

# Install kind with metallb
$SDIR/install-kind.sh

$SDIR/install-ingress-nginx.sh