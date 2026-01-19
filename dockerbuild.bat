docker rmi markchansonartechnologies/firebird-docker-2-1-7cs:latest
docker build . -t markchansonartechnologies/firebird-docker-2-1-7cs:latest
docker push markchansonartechnologies/firebird-docker-2-1-7cs:latest
@echo off
rem pause
timeout /t 30