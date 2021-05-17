CREATE FUNCTION country_in(cstring)
RETURNS country
AS '$libdir/country'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION country_out(country)
RETURNS cstring
AS '$libdir/country'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION country_recv(internal)
RETURNS country
AS '$libdir/country'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION country_send(country)
RETURNS bytea
AS '$libdir/country'
LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE country (
    INPUT          = country_in,
    OUTPUT         = country_out,
    RECEIVE        = country_recv,
    SEND           = country_send,
    LIKE           = "char",
    CATEGORY       = 'S'
);
COMMENT ON TYPE country IS 'a country internaly stored as int8';


CREATE FUNCTION country_name(country)
RETURNS TEXT
AS '$libdir/country'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION country_common_name(country)
RETURNS TEXT
AS '$libdir/country'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION country_eq(country, country)
RETURNS boolean LANGUAGE internal IMMUTABLE STRICT AS 'chareq';

CREATE FUNCTION country_ne(country, country)
RETURNS boolean LANGUAGE internal IMMUTABLE STRICT AS 'charne';

CREATE FUNCTION country_lt(country, country)
RETURNS boolean LANGUAGE internal IMMUTABLE STRICT AS 'charlt';

CREATE FUNCTION country_le(country, country)
RETURNS boolean LANGUAGE internal IMMUTABLE STRICT AS 'charle';

CREATE FUNCTION country_gt(country, country)
RETURNS boolean LANGUAGE internal IMMUTABLE STRICT AS 'chargt';

CREATE FUNCTION country_ge(country, country)
RETURNS boolean LANGUAGE internal IMMUTABLE STRICT AS 'charge';

CREATE FUNCTION country_cmp(country, country)
RETURNS integer LANGUAGE internal IMMUTABLE STRICT AS 'btcharcmp';

CREATE FUNCTION hash_country(country)
RETURNS integer LANGUAGE internal IMMUTABLE STRICT AS 'hashchar';

DO $$
DECLARE version_num integer;
BEGIN
  SELECT current_setting('server_version_num') INTO STRICT version_num;
  IF version_num > 90600 THEN
    EXECUTE $E$ ALTER FUNCTION country_in(cstring) PARALLEL SAFE $E$;
    EXECUTE $E$ ALTER FUNCTION country_out(country) PARALLEL SAFE $E$;
    EXECUTE $E$ ALTER FUNCTION country_name(country) PARALLEL SAFE $E$;
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

CREATE OPERATOR = (
    LEFTARG = country,
    RIGHTARG = country,
    PROCEDURE = country_eq,
    COMMUTATOR = '=',
    NEGATOR = '<>',
    RESTRICT = eqsel,
    JOIN = eqjoinsel
);
COMMENT ON OPERATOR =(country, country) IS 'equals?';

CREATE OPERATOR <> (
    LEFTARG = country,
    RIGHTARG = country,
    PROCEDURE = country_ne,
    COMMUTATOR = '<>',
    NEGATOR = '=',
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);
COMMENT ON OPERATOR <>(country, country) IS 'not equals?';

CREATE OPERATOR < (
    LEFTARG = country,
    RIGHTARG = country,
    PROCEDURE = country_lt,
    COMMUTATOR = > ,
    NEGATOR = >= ,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);
COMMENT ON OPERATOR <(country, country) IS 'less-than';

CREATE OPERATOR <= (
    LEFTARG = country,
    RIGHTARG = country,
    PROCEDURE = country_le,
    COMMUTATOR = >= ,
    NEGATOR = > ,
  RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);
COMMENT ON OPERATOR <=(country, country) IS 'less-than-or-equal';

CREATE OPERATOR > (
    LEFTARG = country,
    RIGHTARG = country,
    PROCEDURE = country_gt,
    COMMUTATOR = < ,
    NEGATOR = <= ,
  RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);
COMMENT ON OPERATOR >(country, country) IS 'greater-than';

CREATE OPERATOR >= (
    LEFTARG = country,
    RIGHTARG = country,
    PROCEDURE = country_ge,
    COMMUTATOR = <= ,
    NEGATOR = < ,
  RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);
COMMENT ON OPERATOR >=(country, country) IS 'greater-than-or-equal';

CREATE OPERATOR CLASS btree_country_ops
DEFAULT FOR TYPE country USING btree
AS
  OPERATOR        1       <  ,
  OPERATOR        2       <= ,
  OPERATOR        3       =  ,
  OPERATOR        4       >= ,
  OPERATOR        5       >  ,
  FUNCTION        1       country_cmp(country, country);

CREATE OPERATOR CLASS hash_country_ops
DEFAULT FOR TYPE country USING hash
AS
  OPERATOR        1       = ,
  FUNCTION        1       hash_country(country);
