CREATE FUNCTION int4_to_country(int4)
RETURNS country
AS '$libdir/country'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION country_to_int4(country)
RETURNS int4
AS '$libdir/country'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION int2_to_country(int2)
RETURNS country
AS '$libdir/country'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION country_to_int2(country)
RETURNS int2
AS '$libdir/country'
LANGUAGE C IMMUTABLE STRICT;

DO $$
DECLARE version_num integer;
BEGIN
  SELECT current_setting('server_version_num') INTO STRICT version_num;
  IF version_num > 90600 THEN
    ALTER FUNCTION int4_to_country(int4) PARALLEL SAFE;
    ALTER FUNCTION country_to_int4(country) PARALLEL SAFE;
    ALTER FUNCTION int2_to_country(int2) PARALLEL SAFE;
    ALTER FUNCTION country_to_int2(country) PARALLEL SAFE;
  END IF;
END;
$$;

CREATE CAST (int4 as country)
WITH FUNCTION int4_to_country(int4);

CREATE CAST (country as int4)
WITH FUNCTION country_to_int4(country);

CREATE CAST (int2 as country)
WITH FUNCTION int2_to_country(int2);

CREATE CAST (country as int2)
WITH FUNCTION country_to_int2(country);
