# Utilise Debian 11 (Bullseye) comme image de base. Debian est une distribution stable et sécurisée.
FROM debian:bullseye

# Mise à jour des paquets disponibles pour s'assurer d'avoir la dernière version des logiciels.
RUN apt update -y 

# Installation de NGINX pour servir des fichiers web.
RUN apt install -y nginx

# Installation de Vim, bien que dans un contexte de production, l'éditeur peut être superflu.
RUN apt install -y vim

# Installation de curl, un outil de ligne de commande pour tester les requêtes HTTP. 
RUN apt install -y curl

# Création du répertoire où les certificats SSL seront stockés.
# Bonne pratique : Créer ce répertoire pour organiser les certificats SSL.
RUN mkdir -p /etc/nginx/ssl

# Installation d'OpenSSL pour générer des certificats SSL auto-signés.
RUN apt install -y openssl

# Génération d'un certificat SSL auto-signé pour sécuriser les connexions HTTPS.
# - `req` génère un certificat X.509.
# - `-x509` pour spécifier que c'est un certificat auto-signé.
# - `-nodes` pour indiquer de ne pas chiffrer la clé privée.
# - Les informations du certificat (C, ST, L, O, etc.) sont spécifiées ici.
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=PARIS/O=42/OU=42/CN=raveriss.42.fr/UID=raveriss"

# Création du répertoire où NGINX stocke son fichier PID.
# Ce répertoire est nécessaire pour que NGINX fonctionne correctement.
RUN mkdir -p /var/run/nginx

# Copie du fichier de configuration NGINX personnalisé dans le répertoire de configuration.
# Ce fichier doit être adapté pour répondre aux besoins spécifiques de l'application.
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Modification des permissions du répertoire où sont stockés les fichiers web.
# 755 signifie que l'utilisateur propriétaire peut lire, écrire et exécuter, tandis que les autres utilisateurs peuvent lire et exécuter.
RUN chmod 755 /var/www/html

# Changement du propriétaire et du groupe du répertoire web pour correspondre à l'utilisateur 'www-data', utilisé par NGINX.
# Cela permet à NGINX d'accéder aux fichiers web sans problème.
RUN chown -R www-data:www-data /var/www/html

# Commande pour lancer NGINX en mode 'daemon off'. 
# Cela permet à NGINX de s'exécuter au premier plan, ce qui est nécessaire pour que Docker maintienne le conteneur en fonctionnement.
CMD ["nginx", "-g", "daemon off;"]
