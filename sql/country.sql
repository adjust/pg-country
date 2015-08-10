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
	CATEGORY       = 'S',
  DEFAULT        = '',
  INTERNALLENGTH = 1,
  ALIGNMENT      = char,
  STORAGE        = PLAIN,
  PASSEDBYVALUE
);
COMMENT ON TYPE country IS 'a country internaly stored as int8';

CREATE FUNCTION country_eq(country, country)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'chareq';

CREATE FUNCTION country_ne(country, country)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'charne';

CREATE FUNCTION country_lt(country, country)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'charlt';

CREATE FUNCTION country_le(country, country)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'charle';

CREATE FUNCTION country_gt(country, country)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'chargt';

CREATE FUNCTION country_ge(country, country)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'charge';

CREATE FUNCTION country_cmp(country, country)
RETURNS integer LANGUAGE internal IMMUTABLE AS 'btcharcmp';

CREATE FUNCTION hash_country(country)
RETURNS integer LANGUAGE internal IMMUTABLE AS 'hashchar';

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
