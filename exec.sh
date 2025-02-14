#!/usr/bin/env bash

set -e

# Start the topology as defined in https://debezium.io/documentation/reference/stable/tutorial.html
export DEBEZIUM_VERSION=2.1

# Modify records in the database via MySQL client
docker-compose -f docker-compose-mysql.yaml \
    exec mysql bash -c "${@:-bash}"


