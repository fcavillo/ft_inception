FROM debian:buster

MAINTAINER Florian Cavillon <fcavillo@student.42.fr>

RUN apt-get -y update && apt-get -y install mariadb-server

EXPOSE 3306

COPY tools/setup.sh .
RUN chmod +x setup.sh

RUN rm /etc/mysql/mariadb.conf.d/50-server.cnf 
COPY tools/50-server.cnf /etc/mysql/mariadb.conf.d/

CMD bash setup.sh
