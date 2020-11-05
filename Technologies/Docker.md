# Docker

## Command line

### Building

The below code will build the local files "." and tag the image with "harveywest/my-app:tag". The "-d" means detached so it does not pipe results to the console.

`docker build -t harveywest/my-app:tag .`
`docker build -t -d harveywest/my-app:tag .`

### Running

The below code will run the docker image "harveywest/my-app:dev" and expose port 80 via port 80.
Once it has finished, it will clean up after itself with "rm".

`docker run -p 80:80 --rm harveywest/my-app:dev"`

#### Running in console

You can include into your run command that it runs in the current console window, then when you ctrl-c it will stop the process. Usefull if you want to see logs.

`docker run -p 80:80 --rm -it harveywest/my-app:dev"`

### Seeing what's running

`docker ps -a"`

### Stopping/Killing

Stopping will attempt to gracefull stop the container. Or you can brutally murder it with kill.

`docker stop <containerid>`
`docker kill <containerid>`

I have created a script called DockerStopAll which is helpful but
remember to clean after `docker system prune --volumes`

## Cleaning

`docker ps -a`

Run the below in powershell only:

`docker rmi $(docker images -f dangling=true -q)` - Deletes dangling containers.

`docker rm -v $(docker ps -a -q -f status=exited)` - Deletes exited containers

### Deleting all images:

Open gitbash and you can run this command to clean all your images:

`docker images -a | awk '{print $3}' | xargs docker rmi`

Equally you can delete some which match a certain patter:

`docker images -a | grep "pattern" | awk '{print $3}' | xargs docker rmi`

## Dockerfile commands

Command Description - <https://docs.docker.com/engine/reference/builder/>
ADD

Copies a file from the host system onto the container

CMD

The command that runs when the container starts

ENV

Sets an environment variable in the new container

EXPOSE

Opens a port for linked containers

FROM

The base image to use in the build. This is mandatory and must be the first command in the file.

MAINTAINER

An optional value for the maintainer of the script

ONBUILD

A command that is triggered when the image in the Dcokerfile is used as a base for another image

RUN

Executes a command and save the result as a new layer

USER

Sets the default user within the container

VOLUME

Creates a shared volume that can be shared among containers or by the host machine

WORKDIR

Set the default working directory for the container

## Docker Gen

[Docker-gen]<https://github.com/jwilder/docker-gen> is a small utility that uses docker APIs and exposes container meta-data to templates. Templates are rendered and an optional notification command can be run to restart the service.

Using docker-gen, we can generate Nginx config files automatically and reload nginx when they change. The same approach can also be used for docker log management.
