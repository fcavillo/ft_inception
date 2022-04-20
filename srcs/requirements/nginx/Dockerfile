FROM debian:buster

MAINTAINER Florian Cavillon <fcavillo@student.42.fr>

RUN apt-get -y update

# INSTALL NGINX
RUN apt-get -y install nginx

CMD ["echo", "NGINX image created"]


# INSTALL PHP
RUN apt-get -y install php7.3 php-mysql php-fpm php-cli php-mbstring

# INSTALL TOOLS
RUN apt-get -y install wget

COPY ./srcs/* srcs/

EXPOSE 443

RUN chmod +x ./srcs/setup.sh
CMD bash ./srcs/setup.sh
