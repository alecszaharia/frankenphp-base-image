# Brizy FrankenPHP Base Image

This repository provides a base Docker image for Symfony applications using [FrankenPHP](https://frankenphp.dev/).

## Available Image Tags

- **`brizy-frankenphp-prod`**: Production-ready base image for FrankenPHP.
- **`brizy-frankenphp-dev`**: Development-ready base image for FrankenPHP (includes additional tools and configurations for development).

### 1. Create a `Dockerfile` in Your Project Root

### 2. Build the Base Image

```
docker build -t brizy-frankenphp-prod -target={frankenphp_dev|frankenphp_prod} .
```

#### Example `Dockerfile`

```dockerfile
FROM composer AS dependencies
WORKDIR /root/app
COPY --link composer.* symfony.* ./
RUN set -eux; \
    composer install --no-cache --prefer-dist --no-dev --no-autoloader --no-scripts --no-progress

FROM brizy-frankenphp-prod AS base

COPY --link . ./
COPY --from=dependencies /root/app/vendor ./vendor

RUN set -eux; \
    mkdir -p var/cache var/log; \
    composer dump-autoload --classmap-authoritative --no-dev; \
    composer dump-env prod; \
    composer run-script --no-dev post-install-cmd; \
    chmod +x bin/console; sync;
```

## Notes

- Ensure your application is compatible with FrankenPHP by following the [FrankenPHP documentation](https://frankenphp.dev/docs/).
- Adjust the Dockerfile as needed for your specific project requirements.
