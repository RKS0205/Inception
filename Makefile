HOSTNAME = $(shell cat /etc/hosts | grep rkenji-s.42.fr)

all: up

up:
	sudo chmod a+w /etc/hosts && sudo cat /etc/hosts | grep rkenji-s.42.fr || \
	sudo echo "127.0.0.1 rkenji-s.42.fr" >> /etc/hosts

	sudo mkdir -p /home/rkenji-s/data/db && sudo chmod 777 /home/rkenji-s/data/db
	sudo mkdir -p /home/rkenji-s/data/wordpress && sudo chmod 777 /home/rkenji-s/data/wordpress
	sudo docker-compose -f srcs/docker-compose.yml up -d

down:
	sudo docker-compose -f srcs/docker-compose.yml down

rebuild:
	sudo docker-compose -f srcs/docker-compose.yml build --no-cache

clean:
	sudo docker-compose -f srcs/docker-compose.yml down -v --rmi all --remove-orphans
	sudo -n sed '/127.0.0.1 rkenji-s.42.fr/d' /etc/hosts -n
	sudo rm -rf /home/rkenji-s

fclean: clean
	sudo docker system prune --volumes --all --force

re: fclean all

.PHONY: all