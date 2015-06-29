#!/bin/bash 

# Initialize the installation config.

set -eu

sed -i \
	-e "s,@SERVER_URL@,$SERVER_URL,g" \
	-e "s,@RDECK_BASE@,$RDECK_BASE,g" \
	server/config/rundeck-config.properties && cat server/config/rundeck-config.properties
sed -i \
	-e "s,@ADMIN_USER@,$ADMIN_USER,g" \
	-e "s,@ADMIN_PASS@,$ADMIN_PASS,g" \
	server/config/realm.properties && cat server/config/realm.properties

sed -i \
	-e "s,@RDECK_BASE@,$RDECK_BASE,g" \
	-e "s,@SERVER_NAME@,$SERVER_NAME,g" \
	-e "s,@SERVER_URL@,$SERVER_URL,g" \
	-e "s,@ADMIN_USER@,$ADMIN_USER,g" \
	-e "s,@ADMIN_PASS@,$ADMIN_PASS,g" \
	etc/framework.properties && cat etc/framework.properties

sed -i \
	-e "s,@RDECK_BASE@,$RDECK_BASE,g" \
	etc/profile

sed -i \
	-e "s,@RDECK_BASE@,$RDECK_BASE,g" \
	etc/log4j.properties


