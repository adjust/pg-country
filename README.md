[![Build Status](https://travis-ci.org/adjust/pg-country.svg)](https://travis-ci.org/adjust/pg-country)

# PG Country

A 1-byte country data-type for PostgreSQL. The extension follows ISO 3166-1
Alpha 2 standard for country names and allows for the following operations.

### Installation

You can clone the extension and run the standard `make && make install` to
build it against your PostgreSQL server.

### Usage

The following example illustrates the use of the `country` type.

```SQL
CREATE TABLE events (id serial, origin country);

INSERT INTO events (values
  (1, 'de'),
  (2, 'us'),
  (3, 'de')
);

SELECT * FROM events ORDER BY origin;
```

The result from the above execution will be:

```
 id | origin
----+--------
  1 | de
  3 | de
  2 | us
(3 rows)
```

### Development

To run the tests, clone and run `make && make install && make installcheck`.
[Dumbo](https://github.com/adjust/dumbo) is the recommended development tool for
the extension.
