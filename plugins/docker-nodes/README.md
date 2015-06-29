Generates resource model source info. Each container is listed as a Node.
Queries the docker service for running containers.

Very trivial implementation that calls the `docker ps` and `docker inspect` CLI tools.

TODO: make query more efficient.