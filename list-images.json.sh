#!/bin/bash

export DOCKER_HOST=$1
export DOCKER_TLS_VERIFY=$2
export DOCKER_CERT_PATH=$3

output_file=$4

echo "[" | tee $output_file
docker images| while read line
do
	set -- $line
	repository=$1; shift
	tag=$1; shift
	image=$1; shift
	printf "{name:\"%s:%s  %s\", value:\"%s\"},\n" "$repository" "$tag" "$image" "$image"
done  | tee -a $output_file

echo "]" | tee -a $output_file