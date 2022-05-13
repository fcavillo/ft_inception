FROM debian:buster

MAINTAINER Florian Cavillon <fcavillo@student.42.fr>

RUN apt-get -y update && apt-get -y install mariadb-server

EXPOSE 3306

COPY setup.sh .
RUN chmod +x setup.sh
CMD bash setup.sh
