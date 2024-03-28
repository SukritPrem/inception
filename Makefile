

build:
	docker compose build

run:
	docker compose up

stop:
	docker compose down

setup:
	@mkdir -p /home/spipitku/data/mariadb/
	@mkdir -p /home/spipitku/data/wordpress/

clean:
	docker compose down --volumes

fclean: clean
	rm -rf /home/spipitku/data/mariadb/
	rm -rf /home/spipitku/data/wordpress/

clean-image:
	docker rmi -f $(docker images -a -q)
	
clean-all:
	docker system prune