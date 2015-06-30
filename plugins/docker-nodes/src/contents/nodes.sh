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
        Created=$(docker inspect -f '{{.Created}}' $container)
        containerId=$(docker inspect -f '{{.Id}}' $container)

        hostname=$(docker inspect -f '{{.Config.Hostname}}' $container)
        username=$(docker inspect -f '{{.Config.User}}' $container)
        exposed_ports=$(docker inspect -f '{{.Config.ExposedPorts}}' $container)
        image=$(docker inspect -f '{{.Config.Image}}' $container)
        WorkingDir=$(docker inspect -f '{{.Config.WorkingDir}}' $container)
        name=$(docker inspect -f '{{.Name}}' $container)

        Running=$(docker inspect -f '{{.State.Running}}' $container)
        Paused=$(docker inspect -f '{{.State.Paused}}' $container)

        IPAddress=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' $container)


cat <<EOF
<node  name='$container' description='$name' containerId='$containerId' username='$username' tags='container,$image' hostname='$hostname' >
<attribute name="ExposedPorts" value='$exposed_ports'/>
<attribute name="WorkingDir" value='$WorkingDir'/>
<attribute name="Running" value='$Running'/>
<attribute name="Paused" value='$Paused'/>
<attribute name="Name" value='$name'/>
<attribute name="Image" value='$image'/>
<attribute name="Created" value='$Created'/>
<attribute name="NetworkSettings:IPAddress" value='$IPAddress'/>
</node>
EOF
done

echo "</project>"