# Utilisation de l'image de base Debian Bullseye (Debian 11)
# Il est important de spécifier une version stable pour assurer la reproductibilité du build.
FROM debian:bullseye

# Mise à jour de la liste des paquets et mise à niveau des paquets existants.
# Bonne pratique : combiner update et upgrade en une seule commande pour minimiser le nombre de couches dans l'image.
RUN apt-get update -y && apt-get upgrade -y

# Installation des paquets MariaDB et de procps.
# procps est utilisé pour des outils comme 'ps', qui peuvent être utiles dans les scripts.
RUN apt-get install -y mariadb-server mariadb-client procps

# Copie du fichier de configuration personnalisé de MariaDB.
# Ce fichier définit les paramètres spécifiques à MariaDB et permet de personnaliser le comportement du serveur.
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Création des répertoires nécessaires pour MariaDB s'ils n'existent pas déjà.
# Bonne pratique : utiliser 'mkdir -p' pour éviter les erreurs si le répertoire existe déjà.
RUN mkdir -p /var/run/mysqld /var/lib/mysql

# Changement du propriétaire des répertoires créés.
# MariaDB doit pouvoir accéder et écrire dans ces répertoires.
RUN chown mysql:mysql /var/run/mysqld /var/lib/mysql

# Définition des permissions sur les répertoires pour permettre à MariaDB de les utiliser correctement.
# 755 permet au propriétaire d'écrire, et aux autres utilisateurs de lire et d'exécuter.
RUN chmod -R 755 /var/run/mysqld /var/lib/mysql

# Exposition du port 3306 (port par défaut de MariaDB).
# Cela permet de rendre MariaDB accessible à d'autres conteneurs ou à l'extérieur du conteneur Docker.
EXPOSE 3306

# Copie du script d'initialisation de MariaDB dans le conteneur.
# Ce script contient les commandes nécessaires pour initialiser la base de données et les utilisateurs.
COPY ./tools/mariadb_script.sh .

# Rend le script exécutable pour pouvoir le lancer comme point d'entrée.
RUN chmod +x ./mariadb_script.sh

# Définition du point d'entrée du conteneur.
# Le script d'initialisation sera exécuté au démarrage du conteneur.
ENTRYPOINT ["bash", "./mariadb_script.sh"]
