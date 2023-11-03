#!/bin/bash

DIR=$(dirname ${BASH_SOURCE[0]})

# Creates a kind cluster

$DIR/install-kind.sh

# Install the backend

$DIR/create-backend.sh

# Start the live race.

$DIR/run-live-race.sh
