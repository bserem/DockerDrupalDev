#!/bin/bash

docker-compose up -d

if [ ! -f web/sites/default/settings.php ]; then
  cat <<EOF > sites/default/settings.php
<?php
\$update_free_access = FALSE;
\$base_url = 'http://localhost:8000';
ini_set('session.gc_probability', 1);
ini_set('session.gc_divisor', 100);
ini_set('session.gc_maxlifetime',   200000);
ini_set('session.cookie_lifetime',  2000000);
\$databases = array (
  'default' =>
  array (
    'default' =>
    array (
      'driver' => 'mysql',
      'database' => 'drupal',
      'username' => 'drupal',
      'password' => 'drupal',
      'host' => 'mariadb',
      'port' => '',
      'prefix' => '',
    ),
  ),
);
EOF
  salt=`openssl rand -base64 32`
  echo "\$drupal_hash_salt = '$salt';" >> sites/default/settings.php

  # Create required filesystem folders
  mkdir -p web/sites/default/files && chmod 777 web/sites/default/files
  # mkdir -p temp && chmod 777 temp

  echo "Drupal initialized."
fi

# Enable stage_file_proxy module to work locally with assets from a remote site
if [ $1 ]; then
  docker-compose exec php drush --root=/var/www/html/web dl stage_file_proxy -y
  docker-compose exec php drush --root=/var/www/html/web en stage_file_proxy -y
  docker-compose exec php drush --root=/var/www/html/web vset stage_file_proxy_origin $1
  docker-compose exec php drush --root=/var/www/html/web cr
  echo "Stage file proxy installed."
fi

alias drush="docker-compose exec php drush --root=/var/www/html/web"
alias stopdev="docker-compose kill && unalias drush && unalias stopdev && echo 'Bye bye!'"
echo "Drush configured for dockerized drush."
echo "Type 'stopdev' to shut down docker and unset all aliases."
echo "Docker up and running, start working."
echo "Taking you to Drupal root folder."
cd web
echo "Use the link below to login as user 1:"
docker-compose exec php drush --root=/var/www/html/web --uri=http://localhost:8000 uli
