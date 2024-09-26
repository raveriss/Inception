#!/bin/bash

# Attendre 10 secondes pour s'assurer que MariaDB a bien démarré
# Idéalement, remplacer ce 'sleep' par une boucle qui teste la connexion à MariaDB.
until mysqladmin ping -h mariadb --silent; do
    echo "Waiting for MariaDB to be ready..."
    sleep 2
done


# Se déplacer dans le répertoire WordPress
cd /var/www/html/wordpress

# Vérifier si WordPress a déjà été configuré (si le fichier wp-config.php existe)
if [ ! -f wp-config.php ]; then
	echo "Creating wp-config.php ..."

	# Utiliser wp-cli pour créer le fichier wp-config.php avec les informations de la base de données
	wp config create --allow-root \
		--dbname=${SQL_DATABASE} \
		--dbuser=${SQL_USER} \
		--dbpass=${SQL_PASSWORD} \
		--dbhost=mariadb \
		--path='/var/www/html/wordpress' \
		--url=https://${DOMAIN_NAME}

	# Installer WordPress en utilisant wp-cli avec les informations de l'administrateur
	wp core install --allow-root \
		--path='/var/www/html/wordpress' \
		--url=https://${DOMAIN_NAME} \
		--title=${SITE_TITLE} \
		--admin_user=${ADMIN_USER} \
		--admin_password=${ADMIN_PASSWORD} \
		--admin_email=${ADMIN_EMAIL}

	# Créer un second utilisateur avec wp-cli
	wp user create --allow-root \
		${SECOND_USER} ${SECOND_USER_EMAIL} \
		--role=author \
		--user_pass=${SECOND_USER_PASSWORD}

	# Vider le cache de WordPress pour appliquer les changements
	wp cache flush --allow-root
	echo "wp-config.php created successfully!"
fi

# Vérifier si le répertoire /run/php existe, sinon le créer
if [ ! -d /run/php ]; then
	mkdir /run/php;
fi

# Démarrer PHP-FPM en mode premier plan pour éviter que le conteneur ne se termine
exec /usr/sbin/php-fpm7.4 -F -R
