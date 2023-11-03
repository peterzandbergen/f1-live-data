#!/bin/bash

DIR=$(dirname ${BASH_SOURCE[0]})

# Creates a kind cluster

$DIR/install-kind.sh

# Install the backend

$DIR/create-backend.sh

# Load the data.

$DIR/load-saved-race.sh

# Start the saved race.

$DIR/run-saved-race.sh
