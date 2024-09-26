#!/bin/bash
# Le script utilise Bash comme interpréteur

# Démarre MariaDB en arrière-plan. 
# Cependant, il est recommandé de ne pas utiliser 'service' dans Docker, 
# mais plutôt de démarrer directement le processus principal de MySQL en avant-plan. 
# Ici, nous remplaçons 'service mariadb start' par 'mysqld_safe' pour éviter cela.

# Création de la base de données si elle n'existe pas déjà.
# La variable d'environnement SQL_DATABASE est utilisée pour nommer la base de données.
# Les variables d'environnement sont récupérées depuis le fichier .env défini dans docker-compose.yml.

service mariadb start;

# Création de la base de données si elle n'existe pas déjà.
# La variable d'environnement SQL_DATABASE est utilisée pour nommer la base de données.
# Les variables d'environnement sont récupérées depuis le fichier .env défini dans docker-compose.yml.
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"

# Création de l'utilisateur SQL si celui-ci n'existe pas déjà.
# L'utilisateur est défini avec le nom SQL_USER et un mot de passe sécurisé SQL_PASSWORD.
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"

# Accord de tous les privilèges à l'utilisateur SQL sur la base de données définie dans SQL_DATABASE.
# L'utilisateur pourra accéder à cette base depuis n'importe quelle IP (l'option '@%').
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"

# Modification du mot de passe de l'utilisateur root pour le rendre plus sécurisé.
# SQL_ROOT_PASSWORD est une variable sensible, elle doit être correctement stockée dans les secrets.
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"

# Rechargement des privilèges pour que toutes les modifications soient appliquées immédiatement.
mysql -e "FLUSH PRIVILEGES;"

# Arrêt propre du serveur MySQL après la configuration pour permettre à Docker de gérer le processus MySQL.
# mysqladmin shutdown permet de s'assurer que MySQL est correctement arrêté avant redémarrage.
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown


# Démarre MariaDB en mode sécurisé au premier plan.
# Utilisation de 'exec' pour s'assurer que le processus MySQL prend le PID 1 dans le conteneur.
exec mysqld_safe

# Affichage d'un message de confirmation pour indiquer que la base de données et l'utilisateur ont bien été créés.
echo "MariaDB database and user were created successfully! " 