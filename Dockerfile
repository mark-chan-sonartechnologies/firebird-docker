FROM ubuntu:22.04
LABEL Maintainer="Mark Chan <mark.chan@sonartechnologies.com>"
LABEL Firebird="2.1.7-classic"

ENV FIREBIRD_PATH=/opt/firebird
ENV FIREBIRD_DATA_PATH=/home/firebird
ENV FIREBIRD_DB_PASSWORD=masterkey
ENV FIREBIRD_DB_PASSWORD_DEFAULT=masterkey


RUN apt-get update
RUN apt-get install wget -y
RUN apt-get install libstdc++5 -y
RUN apt-get install xinetd -y
RUN apt-get install libncurses5 -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install tzdata -y
RUN wget http://sourceforge.net/projects/firebird/files/firebird-linux-amd64/2.1.7-Release/FirebirdCS-2.1.7.18553-0.amd64.tar.gz
RUN tar -vzxf FirebirdCS-2.1.7.18553-0.amd64.tar.gz
RUN rm FirebirdCS-2.1.7.18553-0.amd64.tar.gz
RUN rm FirebirdCS-2.1.7.18553-0.amd64/install.sh
RUN rm FirebirdCS-2.1.7.18553-0.amd64/scripts/postinstall.sh

#ENV TZ="Australia/Sydney"
#RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY install.sh FirebirdCS-2.1.7.18553-0.amd64
COPY postinstall.sh FirebirdCS-2.1.7.18553-0.amd64/scripts

RUN cd FirebirdCS-2.1.7.18553-0.amd64 && ./install.sh ${FIREBIRD_DB_PASSWORD_DEFAULT}
RUN rm -r FirebirdCS-2.1.7.18553-0.amd64

COPY fbudflib2.so ${FIREBIRD_PATH}/UDF
COPY entrypoint.sh ${FIREBIRD_PATH}

#RUN cd ${FIREBIRD_PATH} && mkdir DBA && chown firebird:firebird DBA && chmod -R 770 DBA
RUN cd ${FIREBIRD_PATH} && chmod +x entrypoint.sh
#RUN cd / && mkdir dba && chown firebird:firebird dba && chmod -R 770 dba && touch /dba/abcde
RUN mkdir -p ${FIREBIRD_DATA_PATH} && chown firebird:firebird ${FIREBIRD_DATA_PATH} && chmod -R 770 ${FIREBIRD_DATA_PATH}

RUN echo >> /etc/bash.bashrc && echo alias l='"ls -l"' >> /etc/bash.bashrc
RUN echo >> /root/.bashrc && echo alias l='"ls -l"' >> /root/.bashrc

VOLUME ["/home/firebird"]
#VOLUME ["/dba"]
#VOLUME ["/opt/firebird"]


EXPOSE 3050/tcp

WORKDIR ${FIREBIRD_PATH}
ENTRYPOINT ${FIREBIRD_PATH}/entrypoint.sh 
