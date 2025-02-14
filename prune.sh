#!/usr/bin/env bash

set -e

# Start the topology as defined in https://debezium.io/documentation/reference/stable/tutorial.html
export DEBEZIUM_VERSION=2.1
docker system prune -f --volumes
