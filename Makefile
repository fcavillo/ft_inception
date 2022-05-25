# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fcavillo <fcavillo@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/01/21 01:49:00 by fcavillo          #+#    #+#              #
#    Updated: 2022/05/25 11:13:25 by fcavillo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = inception

all : build

stop: down clean
	sudo systemctl stop nginx
	sudo systemctl disable nginx
	sudo service nginx stop
	sudo service mysql stop
	

#starts all services from the yml file
build : 
	docker-compose -f srcs/docker-compose.yml up --build --remove-orphans

#stops containers and removes containers, networks, volumes, and images created by up
down:
	docker-compose -f  srcs/docker-compose.yml down -v

#removes all previous container related data
clean:
	docker system prune

fclean: clean

volumes: 
	sudo rm -rf /home/user42/data/wp_data/*
	sudo rm -rf /home/user42/data/db_data/*

.PHONY:	all clean fclean build down
