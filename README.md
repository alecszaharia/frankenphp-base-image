## This image is designed to be used as a base image for PHP applications using FrankenPHP.

To use this Docker image as a base for your own project, follow these steps:

### Note there are two tags available for this image:
- ```brizy-frankenphp-prod```: Production-ready base image for FrankenPHP.
- ```brizy-frankenphp-dev```: Development-ready base image for FrankenPHP. (includes additional tools and configurations for development purposes)

### 1. Create a `Dockerfile` in your project root

### 2. Choose a base image stage

You can use one of the following stages as your base image:
- `brizy-frankenphp-prod` (base)
- `brizy-frankenphp-dev` (development)

Example:
```dockerfile
FROM composer AS dependencies
WORKDIR /root/app
COPY --link composer.* symfony.* ./
RUN set -eux; \
	composer install --no-cache --prefer-dist --no-dev --no-autoloader --no-scripts --no-progress

FROM brizy-frankenphp-prod AS base

COPY --link . ./
COPY --from=dependencies /root/app/vendor ./vendor

RUN rm -Rf frankenphp/

RUN set -eux; \
	mkdir -p var/cache var/log; \
	composer dump-autoload --classmap-authoritative --no-dev; \
	composer dump-env prod; \
	composer run-script --no-dev post-install-cmd; \
	chmod +x bin/console; sync;

```
