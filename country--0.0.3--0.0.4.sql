CREATE FUNCTION country_name(country)
RETURNS TEXT
AS '$libdir/country'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION country_common_name(country)
RETURNS TEXT
AS '$libdir/country'
LANGUAGE C IMMUTABLE STRICT;

DO $$
DECLARE version_num integer;
BEGIN
  SELECT current_setting('server_version_num') INTO STRICT version_num;
  IF version_num > 90600 THEN
    EXECUTE $E$ ALTER FUNCTION country_name(country) PARALLEL SAFE $E$;
    EXECUTE $E$ ALTER FUNCTION country_common_name(country) PARALLEL SAFE $E$;
  END IF;
END;
$$;