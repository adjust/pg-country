BEGIN;
CREATE EXTENSION country;

SELECT country_name(NULL),country_common_name(NULL);
SELECT country_name('bn'),country_common_name('bn');
SELECT country_name('bo'),country_common_name('bo');
SELECT country_name('ci'),country_common_name('ci');
SELECT country_name('fk'),country_common_name('fk');
SELECT country_name('gb'),country_common_name('gb');
SELECT country_name('ir'),country_common_name('ir');
SELECT country_name('kp'),country_common_name('kp');
SELECT country_name('kr'),country_common_name('kr');
SELECT country_name('la'),country_common_name('la');
SELECT country_name('md'),country_common_name('md');
SELECT country_name('ru'),country_common_name('ru');
SELECT country_name('sy'),country_common_name('sy');
SELECT country_name('tw'),country_common_name('tw');
SELECT country_name('tz'),country_common_name('tz');
SELECT country_name('uk'),country_common_name('uk');
SELECT country_name('ve'),country_common_name('ve');

ROLLBACK;