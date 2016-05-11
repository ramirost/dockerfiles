# Tool to get a tunnel to a container without an exposed port

For example, to access to a postgres database of a container named `app-db` from `localhost:5555`

```
./docker_tunnel.sh 5555 app-db 5432
```

## Manual execution

In the following example we will use port `5555` in localhost to access to the target service at port `5432` and the container IP is `172.17.0.2`, that can be obtained this way from the container name `app-db`:

```
docker inspect --format '{{ .NetworkSettings.IPAddress }}' app-db
```

```
docker run -it --rm -p 5555:5555 ramirost/docker-tunnel /bin/sh
socat TCP-LISTEN:5555,fork TCP:172.17.0.2:5432
```

## Build the image

```
docker build -t ramirost/docker-tunnel .
```

Upload to repository

```
docker push ramirost/docker-tunnel
```