# Rundeck
#
# VERSION 0.0.1

# USAGE: docker run -p 14440:4440  --env=SERVER_NAME=$(boot2docker ip) --env=SERVER_URL=http://$(boot2docker ip):14440 ahonor/rundeckpro-ha-aws

FROM        centos:6
MAINTAINER  Alex Honor <alex@simplifyops.com>


# Configuration variables
#
ENV RDECK_BASE=/home/rundeck
ENV SERVER_NAME @SERVER_NAME@
ENV SERVER_PORT 4440
ENV SERVER_URL http://$SERVER_NAME:$SERVER_PORT
ENV ADMIN_USER admin
ENV ADMIN_PASS @ADMIN_PASS@


# Prepare the image.
#

# Create a service account
RUN useradd -d $RDECK_BASE -m rundeck


# Install software dependencies
#
RUN yum install -y curl unzip java-1.7.0
#
# ... and the launcher jar
ADD http://dl.bintray.com/rundeck/rundeck-maven/rundeck-launcher-2.5.1.jar $RDECK_BASE/rundeck-launcher.jar


# Switch to the rundeck base directory
#
WORKDIR $RDECK_BASE

# Generate basic configuration
#
RUN mkdir -vp var/logs/rundeck server/config etc
COPY ./etc/rundeck-config.properties server/config/
COPY ./etc/realm.properties server/config/
COPY ./etc/log4j.properties etc/
COPY ./etc/framework.properties etc/
COPY ./etc/*.aclpolicy etc/
COPY ./etc/profile etc/
COPY ./initialize.sh initialize.sh
COPY ./run.sh run.sh
RUN chown -R rundeck:rundeck .

# Switch to the rundeck user
USER rundeck

# Initialize config files from environment parameters

RUN ./initialize.sh

# Start the service.
ENTRYPOINT ["./run.sh"]
CMD ["start"]


EXPOSE $SERVER_PORT
#VOLUME $RDECK_BASE/projects
#VOLUME $RDECK_BASE/server/logs
#VOLUME $RDECK_BASE/var
#
# -