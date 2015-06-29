#!/bin/bash

# Update the configuration with environment parameters and execute the launcher.

set -eu


echo "INFO: [$0] SERVER_NAME=$SERVER_NAME, SERVER_URL=$SERVER_URL, USER=$(whoami)"
echo "INFO: [$0] \$@: $@"

# Update configuration from docker run flags
#
sed -i -e "s,grails.serverURL=.*,grails.serverURL=$SERVER_URL,g" \
	$RDECK_BASE/server/config/rundeck-config.properties
sed -i \
	-e "s,grails.serverURL=.*,grails.serverURL=$SERVER_URL,g" \
	-e "s,framework.server.url=.*,framework.server.url=$SERVER_URL,g" \
	-e "s,framework.server.name=.*,framework.server.name=$SERVER_NAME,g" \
	-e "s,framework.server.port=.*,framework.server.port=$SERVER_PORT,g" \
	-e "s,framework.server.hostname=.*,framework.server.hostname=$SERVER_NAME,g" \
	$RDECK_BASE/etc/framework.properties

# Execute the launcher
#
exec java -XX:MaxPermSize=256m -Xmx2048m \
	-Dserver.hostname=$SERVER_NAME \
	-Dserver.http.port=$SERVER_PORT \
	-jar $RDECK_BASE/rundeck-launcher.jar

#
# -