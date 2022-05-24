FROM debian:buster

MAINTAINER Florian Cavillon <fcavillo@student.42.fr>

RUN apt-get -y update && apt-get -y install mariadb-server

EXPOSE 3306

COPY setup.sh .
RUN chmod +x setup.sh

RUN rm /etc/mysql/mariadb.conf.d/50-server.cnf 
COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

CMD bash setup.sh
