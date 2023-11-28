-- persistence should persist countries;
-- ./spec/persistence_spec.rb:8;
BEGIN;
CREATE EXTENSION country;
CREATE TABLE country_test AS SELECT 'de'::country, 1 as num;
SELECT * FROM country_test;
UPDATE country_test SET num = 2;
SELECT * FROM country_test;
ROLLBACK;
