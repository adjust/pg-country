
DO $$
DECLARE version_num integer;
BEGIN
  SELECT current_setting('server_version_num') INTO STRICT version_num;
  IF version_num > 90600 THEN
	EXECUTE $E$ ALTER FUNCTION country_in(cstring) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION country_out(country) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION country_recv(internal) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION country_send(country) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION country_eq(country, country) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION country_ne(country, country) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION country_lt(country, country) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION country_le(country, country) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION country_gt(country, country) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION country_ge(country, country) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION country_cmp(country, country) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION hash_country(country) PARALLEL SAFE $E$;
  END IF;
END;
$$;

