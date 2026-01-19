# docker-firebird
Firebird 2.1.7 Classic Server

[Docker Hub](https://hub.docker.com/repository/docker/markchansonartechnologies/firebird-docker-2-1-7cs)

Image is based on:

https://github.com/mahenrique94/docker-firebird

Built with Firebird source from:

http://sourceforge.net/projects/firebird/files/firebird-linux-amd64/2.1.7-Release/FirebirdCS-2.1.7.18553-0.amd64.tar.gz

There is a shared volume /home/firebird.

2 files have been linked to files in the shared volume so you can edit from the host system:

/opt/firebird/aliases.conf -> /home/firebird/config/aliases.conf
/opt/firebird/security2.fdb -> /home/firebird/config/security2.fdb
