# Variables
PROJECT_NAME = inception
DOCKER_COMPOSE = docker-compose
SRC_DIR = srcs
COMPOSE_FILE = $(SRC_DIR)/docker-compose.yml
DC = $(DOCKER_COMPOSE) -f $(COMPOSE_FILE) -p $(PROJECT_NAME)
DATA_DIR = $(HOME)/data

# Cibles
.PHONY: all build up down clean logs ps volumes inspect prune help

# Par défaut, exécuter les cibles build et up
all: build up

# Construire les images Docker et ajuster les permissions des répertoires
build:
	@sudo mkdir -p $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress
	@$(DC) build

# Démarrer les conteneurs Docker
up:
	@$(DC) up -d

# Arrêter et supprimer les conteneurs Docker et le réseau
down:
	@$(DC) down

# Nettoyer les volumes Docker et les données
clean:
	@$(DC) down -v --remove-orphans
	@rm -rf $(DATA_DIR)/mariadb $(DATA_DIR)/wordpress


# Afficher les journaux des conteneurs Docker
logs:
	@$(DC) logs -f

# Afficher l'état des conteneurs Docker du projet
ps:
	@$(DC) ps

# Lister les volumes Docker
volumes:
	@docker volume ls

# Inspecter un volume Docker spécifique
inspect:
	@if [ -z "$(NAME)" ]; then \
		echo "Veuillez spécifier le nom du volume avec 'make inspect-volume NAME=volume_name'"; \
	else \
		docker volume inspect $(NAME); \
	fi

# Nettoyer tous les conteneurs, images, volumes et réseaux Docker (action destructrice)
prune:
	@echo "ATTENTION : Cette action va supprimer TOUS les conteneurs, images, volumes et réseaux Docker sur votre système !"
	@read -p "Êtes-vous sûr de vouloir continuer ? [y/N] " confirm && \
	if [ "$$confirm" = "y" ]; then \
		docker stop $$(docker ps -qa); \
		docker rm $$(docker ps -qa); \
		docker rmi -f $$(docker images -qa); \
		docker volume rm $$(docker volume ls -q); \
		docker network rm $$(docker network ls -q) 2>/dev/null || true; \
	else \
		echo "Action annulée."; \
	fi

# Afficher l'aide
help:
	@echo "Utilisation du Makefile :"
	@echo "  make                  : Construire et démarrer les conteneurs Docker"
	@echo "  make build            : Construire les images Docker"
	@echo "  make up               : Démarrer les conteneurs Docker"
	@echo "  make down             : Arrêter et supprimer les conteneurs Docker et le réseau"
	@echo "  make clean            : Nettoyer les volumes Docker et supprimer les données"
	@echo "  make logs             : Afficher les journaux des conteneurs Docker"
	@echo "  make ps               : Afficher l'état des conteneurs Docker du projet"
	@echo "  make volumes          : Lister les volumes Docker"
	@echo "  make inspect          : Inspecter un volume Docker spécifique (ex: make inspect-volume NAME=volume_name)"
	@echo "  make prune            : Nettoyer TOUT Docker (conteneurs, images, volumes, réseaux)"
	@echo "  make help             : Afficher cette aide"
