FROM debian:buster

MAINTAINER Florian Cavillon <fcavillo@student.42.fr>

RUN apt-get update && apt-get dist-upgrade -yq && apt-get install -yq nginx openssl

CMD ["echo", "NGINX image created"]

RUN apt-get clean && rm -rf /var/lib/apt/lists/

RUN mkdir /var/www/fcavillo.42.fr
RUN chown -R www-data /var/www/*
RUN chmod -R 755 /var/www/*

COPY tools/nginx.conf /etc/nginx/sites-available/fcavillo.42.fr
RUN ln -s /etc/nginx/sites-available/fcavillo.42.fr /etc/nginx/sites-enabled
RUN rm /etc/nginx/sites-enabled/default 

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN openssl req -x509 -nodes -days 365 -newkey rsa:4096 -sha256 -keyout \
/etc/nginx/fcavillo.42.fr.key -out /etc/nginx/fcavillo.42.fr.crt -subj \
"/C=FR/ST=Paris/L=Paris/O=ToysRus/OU=fcavillo/CN=fcavillo.42.fr"

EXPOSE 443

CMD ["usr/sbin/nginx"]
