[![CI](https://github.com/adjust/pg-country/actions/workflows/main.yml/badge.svg)](https://github.com/adjust/pg-country/actions/workflows/main.yml)

# country
A country Extension for PostgreSQL.

The `pg-country` extension create new data types `country`, which is a enum types.

The `country` enumeration values follow the `ISO 3166-1 alpha-2` standard.

The extension also creates comparison operators and operator classes for btree and hash indexes.

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

