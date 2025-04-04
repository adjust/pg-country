BEGIN;
CREATE EXTENSION country;
SELECT 'de'::country::int4;
SELECT 'de'::country::int2;
SELECT 57::int4::country;
SELECT 57::int2::country;
ROLLBACK;
