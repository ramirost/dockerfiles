#!/bin/bash

if [ ! $3 ] 
then
	echo "Usage docker_tunnel.sh local_port container container_port"
	# Example: docker_tunnel.sh 5555 app-db 5432
	exit 1
fi

LOCAL_PORT=$1
CONTAINER_NAME=$2
CONTAINER_PORT=$3

CONTAINER_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CONTAINER_NAME)

printf "Going to run:\n"
printf "  docker run -it --rm -p $LOCAL_PORT:$LOCAL_PORT ramirost/docker-tunnel socat TCP-LISTEN:$LOCAL_PORT,fork TCP:$CONTAINER_IP:$CONTAINER_PORT\n"
printf "You must connect to \033[0;33mlocalhost:$LOCAL_PORT\033[0m to get access to \033[0;33m$CONTAINER_NAME:$CONTAINER_PORT\033[0m\n"
printf "Press Ctrl-C to exit\n"
docker run -it --rm -p $LOCAL_PORT:$LOCAL_PORT ramirost/docker-tunnel socat TCP-LISTEN:$LOCAL_PORT,fork TCP:$CONTAINER_IP:$CONTAINER_PORT
printf "\033[0;33m...Done\033[0m\n"