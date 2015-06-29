#!/bin/bash


set -eu

export DOCKER_HOST=$RD_CONFIG_DOCKER_HOST
export DOCKER_TLS_VERIFY=0
if [[ $RD_CONFIG_DOCKER_TLS_VERIFY == "true" ]]
then
        DOCKER_TLS_VERIFY=1
fi
export DOCKER_CERT_PATH=$RD_CONFIG_DOCKER_CERT_PATH


container="$1"
shift

set -- $@
# check if the command is docker otherwise treat it like ad hoc
if [[ "$1" == "docker" ]]
then
        # treat it like a container command
        shift
        docker $@ ${container}
else
        # treat it like adhoc
        docker exec "${container}" $@
fi