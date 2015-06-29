#!/bin/bash

set -eu

export DOCKER_HOST=$RD_CONFIG_DOCKER_HOST
export DOCKER_TLS_VERIFY=0
if [[ $RD_CONFIG_DOCKER_TLS_VERIFY == "true" ]]
then
	DOCKER_TLS_VERIFY=1
fi
export DOCKER_CERT_PATH=$RD_CONFIG_DOCKER_CERT_PATH

echo "<project>"
docker ps|grep -v 'CONTAINER'|cut -f1 -d" "| while read container
do
        hostname=$(docker inspect -f '{{.Config.Hostname}}' $container)
        username=$(docker inspect -f '{{.Config.User}}' $container)
        exposed_ports=$(docker inspect -f '{{.Config.ExposedPorts}}' $container)
        image=$(docker inspect -f '{{.Config.Image}}' $container)
        containerId=$(docker inspect -f '{{.Id}}' $container)
        status=$(docker inspect -f '{{.State.Running}}' $container)
        name=$(docker inspect -f '{{.Name}}' $container)
        IPAddress=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' $container)
        Created=$(docker inspect -f '{{.Created}}' $container)

cat <<EOF
<node  name='$container' containerId='$containerId' username='$username' exposed_ports='$exposed_ports' tags='container,$image' hostname='$hostname' >
<attribute name="Running" value='$status'/>
<attribute name="Name" value='$name'/>
<attribute name="Image" value='$image'/>
<attribute name="Created" value='$Created'/>
<attribute name="NetworkSettings:IPAddress" value='$IPAddress'/>
</node>
EOF
done

echo "</project>"