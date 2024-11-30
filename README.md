# Inception - École 42 | Paris

<div align="center">
  <img src="https://img.shields.io/badge/container-Docker-blue" alt="Docker">
  <img src="https://img.shields.io/badge/docker%20compose-yes-blue" alt="Docker Compose">
  <img src="https://img.shields.io/badge/database-MariaDB-blue" alt="MariaDB">
  <img src="https://img.shields.io/badge/web%20server-Nginx-green" alt="Nginx">
  <img src="https://img.shields.io/badge/cms-WordPress-blueviolet" alt="WordPress">
  <img src="https://img.shields.io/badge/school-42-green" alt="42">
  <img src="https://img.shields.io/badge/42-Paris-blue" alt="42 Paris">
</div>

###
<div align="center">
  <img src="https://raw.githubusercontent.com/ayogun/42-project-badges/refs/heads/main/badges/inceptione.png?raw=true" alt="Badge du projet push_swap">
</div>

## Description

Inception est un projet qui vise à approfondir les connaissances dans la virtualisation en utilisant Docker. L'objectif est de créer une mini-infrastructure de plusieurs services, tous conteneurisés et orchestrés à l'aide de `docker-compose`. Chaque service tournera dans son propre conteneur dédié en respectant les bonnes pratiques de configuration.

## Exercise 00: Infrastructure Docker

L'objectif principal de ce projet est de mettre en place une infrastructure complète comprenant plusieurs services Docker comme NGINX, WordPress, et MariaDB. Le projet inclut la création d'une machine virtuelle, l'écriture de Dockerfiles, et l'utilisation de volumes et de réseaux Docker.

### Structure du Projet

Le projet est organisé de la manière suivante :

- **File:** `Makefile`
- **Directory:** `srcs/`
  - `docker-compose.yml`
  - `.env`
  - **Directory:** `requirements/`
    - **Directory:** `mariadb/`
      - `Dockerfile`
      - `.dockerignore`
      - `conf/`
      - `tools/`
    - **Directory:** `nginx/`
      - `Dockerfile`
      - `.dockerignore`
      - `conf/`
      - `tools/`
    - **Directory:** `wordpress/`
      - `Dockerfile`
      - `.dockerignore`
      - `tools/`
    - **Directory:** `bonus/`
      - (Dossier pour tout service supplémentaire dans les bonus)


Le fichier `.env` contient des variables d'environnement pour la configuration de votre domaine et des services comme MariaDB et WordPress.


### Description des Fichiers

- `docker-compose.yml`: Contient la configuration des différents services et la mise en place des réseaux et des volumes Docker.
- `Makefile`: Automatiser la création et le déploiement des conteneurs via Docker Compose.
- `Dockerfiles/`: Dossier contenant les Dockerfiles pour chaque service (NGINX, WordPress, MariaDB).
- `Volumes/`: Dossier où les volumes sont montés pour stocker les données persistantes (base de données, fichiers de WordPress).

### Compilation

Pour compiler et démarrer l'infrastructure, utilisez la commande suivante dans le terminal :

```bash
make
```

Cette commande lance `docker-compose` et met en place tous les services.

### Exécution
Une fois la compilation terminée, vous pouvez accéder aux services via votre navigateur :

Accédez à votre site WordPress sécurisé via HTTPS à l'adresse `https://login.42.fr`, où login est votre `login` utilisateur de l'École 42.

### Fonctionnalités
- **Conteneurisation des services** : NGINX, WordPress, et MariaDB tournent chacun dans leur propre conteneur.
- **Sécurisation** : Utilisation du protocole TLSv1.2 ou TLSv1.3 pour sécuriser les connexions via NGINX.
- **Volumes** : Les données sont persistantes grâce à l'utilisation de volumes Docker pour la base de données et les fichiers de WordPress.
- **Automatisation** : Utilisation d'un Makefile pour automatiser la configuration et le déploiement.
- **Variables d'environnement** : Configuration des mots de passe et autres informations sensibles via des variables d'environnement sécurisées dans un fichier `.env`.

### Contributeurs
raveriss - Développeur principal

### Remarques
Ce projet suit les bonnes pratiques de Docker, notamment l'utilisation de Dockerfiles personnalisés pour chaque service et la gestion des volumes pour garantir la persistance des données. Aucun mot de passe n'est stocké dans les Dockerfiles et toutes les informations sensibles sont gérées via des variables d'environnement.

### Ressources Utilisées
- [Testeur inception](https://github.com/raveriss/42-inception-tester)
- [Documentation Docker](https://docs.docker.com)
- [Apprenez Docker sur OpenClassrooms](https://openclassrooms.com/fr/courses/2612166-apprenez-a-utiliser-docker)
- [Utilisation avancée de Docker Compose](https://docs.docker.com/compose/)
