# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fcavillo <fcavillo@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/01/21 01:49:00 by fcavillo          #+#    #+#              #
#    Updated: 2022/05/30 16:22:03 by fcavillo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

.PHONY: all services-stop hosts build up start down destroy stop restart ps logs clean create-dirs rm-dirs

.SILENT: hosts create-dirs rm-dirs

all : hosts create-dirs stop build up

stop:
	sudo systemctl stop nginx
	sudo systemctl disable nginx
	sudo service nginx stop
	sudo service mysql stop
	

#starts all services from the yml file
build : hosts
	docker-compose -f srcs/docker-compose.yml build 

up:
	docker-compose -f srcs/docker-compose.yml up

hosts :
		if grep -R "fcavillo.42.fr" /etc/hosts > /dev/null; then \
			echo 'fcavillo.42.fr already in hosts'; \
		else \
			echo '127.0.0.1 fcavillo.42.fr' | sudo tee -a /etc/hosts > /dev/null; \
		fi
		if grep -R "www.fcavillo.42.fr" /etc/hosts > /dev/null; then \
			echo 'www.fcavillo.42.fr already in hosts'; \
		else \
			echo '127.0.0.1 www.fcavillo.42.fr' | sudo tee -a /etc/hosts > /dev/null; \
		fi
		
#stops containers and removes containers, networks, volumes, and images created by up
down:
	docker-compose -f  srcs/docker-compose.yml down -v

#removes all previous container related data
clean:
	docker system prune

fclean: down clean rm-dirs

dirs:

create-dirs:
		if [ -d "/home/user42/data/db_data" ] ; then \
			echo "Directory /home/user42/data/db_data exists."; \
		else \
			sudo mkdir /home/user42/data/db_data; \
			echo "Directory /home/user42/data/db_data created."; \
		fi
		if [ -d "/home/user42/data/wp_data" ] ; then \
			echo "Directory /home/user42/data/wp_data exists."; \
		else \
			sudo mkdir /home/user42/data/wp_data; \
			echo "Directory /home/user42/data/wp_data created."; \
		fi

rm-dirs: 
	sudo rm -rf /home/user42/data/wp_data
	echo "Directory /home/user42/data/wp_data/ removed."
	sudo rm -rf /home/user42/data/db_data
	echo "Directory /home/user42/data/db_data/ removed."

.PHONY:	all clean fclean build down
