# [Verdaccio](https://github.com/nowhammies/verdaccio-activedirectory) + [ActiveDirectory](https://github.com/nowhammies/verdaccio-activedirectory)

verdaccio + active directory authentication in docker. this repository uses a base image of [`node:alpine`](https://hub.docker.com/_/node/) and the npm packages: [verdaccio](https://github.com/nowhammies/verdaccio-activedirectory) and [verdaccio-activedirectory](https://github.com/nowhammies/verdaccio-activedirectory).

## Environment Parameters

### Verdaccio Related
* `PORT`: tcp port to run verdaccio in, defaults to `4873`;
* `BASIC`: access rights for non scoped packages, defaults to `$all`;
* `SCOPED`: access rights for scoped packages, defaults to `$authenticated`;
* `PROXY`: fallback proxy for not found packages, defaults to `https://registry.npmjs.org`;
* `WEB_ENABLE`: is web page enabled, defaults to `true`;
* `WEB_TITLE`: web page title, defaults to `Verdaccio`;
* `WEB_LOGO`: logo used in web page, defaults to verdaccio logo;

### Active Directory Related
* `DOMAIN`: active directory domain;
* `BASE_DN`: active directory baseDn;

## Volumes
* Configuration File: `/verdaccio/conf/config.yml`;
* Data Storage: `/verdaccio/storage`;

## DOCKER COMPOSE
```yaml
version: '3.3'

services:
  verdaccio:
    image: mateusoli/verdaccio-ad
    ports:
      - 4873:4873
    volumes:
      - verdaccio:/verdaccio/storage
    environment:
      DOMAIN: domain.com
      BASE_DN: dc=domain,dc=com

volumes: 
  verdaccio:
```

## References

* [node-docker](https://hub.docker.com/_/node/);
* [verdaccio](https://github.com/verdaccio/verdaccio);
* [verdaccio-activedirectory](https://github.com/nowhammies/verdaccio-activedirectory);
