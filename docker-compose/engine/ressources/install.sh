#!/bin/sh
if [ -d /var/www/html/public ] ; then
  echo "PUBLIC directory already exist..."
  echo "SORRY : I don't want to break your actual project"
  exit 1
fi

echo "Install Laravel Installer"
composer global require "laravel/installer"
echo "Create Laravel Project"
cd /var/www/html
composer create-project --prefer-dist laravel/laravel .
echo "Latest Version of Laravel is installed"

exit 0