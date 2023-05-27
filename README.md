[![CI](https://github.com/adjust/pg-country/actions/workflows/main.yml/badge.svg)](https://github.com/adjust/pg-country/actions/workflows/main.yml)

# country
An Extension for PostgreSQL.

## Installation from source codes

To install `country`, execute this in the extension's directory:

```shell
make install
```
### Testing

To test the `country`, execute this in the extension's directory:

```shell
make installcheck
```

**Notice:** Don't forget to set the `PG_CONFIG` variable (`make PG_CONFIG=...`)
in case you want to test `country` on a non-default or custom build of PostgreSQL.
Read more [here](https://wiki.postgresql.org/wiki/Building_and_Installing_PostgreSQL_Extension_Modules).

