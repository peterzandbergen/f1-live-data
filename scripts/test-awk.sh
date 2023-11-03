#!/bin/bash

# Strip the first two bytes
echo -n $CIDR | awk  -f $(dirname $0)/test-awk.awk

