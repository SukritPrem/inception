
all: build run

build:
	@docker compose -f ./srcs/docker-compose.yml build

run:
	@docker compose -f ./srcs/docker-compose.yml up

stop:
	@docker compose -f ./srcs/docker-compose.yml down

setup:
	@mkdir -p /home/spipitku/data/mariadb/
	@mkdir -p /home/spipitku/data/wordpress/

clean:
	@docker compose -f ./srcs/docker-compose.yml down --volumes

fclean: clean
	rm -rf /home/spipitku/data/mariadb/
	rm -rf /home/spipitku/data/wordpress/

clean-image:
	docker rmi -f $(docker images -a -q)
	
clean-all:
	docker system prune