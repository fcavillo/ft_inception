# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fcavillo <fcavillo@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/01/21 01:49:00 by fcavillo          #+#    #+#              #
#    Updated: 2022/05/12 15:26:41 by fcavillo         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = inception

all : clean build

#starts all services from the yml file
build : 
	docker-compose -f srcs/docker-compose.yml up --build

#stops containers and removes containers, networks, volumes, and images created by up
down :
	docker-compose down

#removes all previous container related data
clean:
	docker system prune

fclean: clean


.PHONY:	all clean fclean build down
