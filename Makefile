
all: build run

build:
	@docker compose -f ./srcs/docker-compose.yml build

run:
	@docker compose -f ./srcs/docker-compose.yml up

stop:
	@docker compose -f ./srcs/docker-compose.yml down

setup:
	@mkdir -p ${HOME}/data/mariadb/
	@mkdir -p ${HOME}/data/wordpress/

clean:
	@docker compose -f ./srcs/docker-compose.yml down --volumes

fclean: clean
	rm -rf ${HOME}/data/mariadb/
	rm -rf ${HOME}/data/wordpress/

clean-image:
	docker rmi -f $(docker images -a -q)
	
clean-all:
	docker system prune

debug:
	sudo make fclean
	sudo make setup
	sudo make