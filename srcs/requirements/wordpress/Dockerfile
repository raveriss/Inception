# Utiliser Debian 11 (Bullseye) comme base stable
FROM debian:bullseye

# Définir les versions comme variables d'environnement pour faciliter la maintenance
ENV WP_VERSION=6.1.1
ENV PHP_VERSION=7.4

# Mise à jour des paquets, installation de wget, PHP, MySQL client, et nettoyage des fichiers inutiles
RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y wget php${PHP_VERSION} php-fpm php-mysql default-mysql-client mariadb-client openssl && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Téléchargement et installation de WP-CLI, un outil pour gérer WordPress en ligne de commande
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# Téléchargement et extraction de WordPress
RUN wget https://wordpress.org/wordpress-${WP_VERSION}.tar.gz -P /var/www/html && \
    cd /var/www/html && tar -xzf wordpress-${WP_VERSION}.tar.gz && \
    rm wordpress-${WP_VERSION}.tar.gz

# Ajuster les permissions pour que PHP-FPM et NGINX puissent accéder aux fichiers WordPress
RUN chown -R www-data:www-data /var/www/* && \
    chmod -R 755 /var/www/*

# Exposer le port 9000 pour que NGINX puisse communiquer avec PHP-FPM
EXPOSE 9000

# Copier le script d'auto-configuration dans l'image Docker
COPY ./tools/auto_config.sh /usr/local/bin/auto_config.sh

# Rendre le script d'auto-configuration exécutable
RUN chmod +x /usr/local/bin/auto_config.sh

# Copier le fichier de configuration PHP-FPM personnalisé
COPY ./conf/www.conf /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

# Définir le point d'entrée du conteneur, ce qui exécutera le script d'auto-configuration
ENTRYPOINT ["/usr/local/bin/auto_config.sh"]
