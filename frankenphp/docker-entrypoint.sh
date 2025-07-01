#!/bin/sh
set -e

if [ "$1" = 'frankenphp' ] || [ "$1" = 'php' ] || [ "$1" = 'bin/console' ]; then

	# Display information about the current project
	# Or about an error in project initialization
	php bin/console -V

  chown -R "$(whoami)":www-data var
  chmod -R 775 var
  find var -type d -exec chmod 2775 {} \;

	echo 'PHP app ready!'
fi

exec docker-php-entrypoint "$@"
