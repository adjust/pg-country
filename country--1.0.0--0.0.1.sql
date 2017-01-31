----functions----
CREATE OR REPLACE FUNCTION country_cmp(country, country)
 RETURNS integer
 LANGUAGE internal
 IMMUTABLE
AS $function$btcharcmp$function$;
----
CREATE OR REPLACE FUNCTION country_ge(country, country)
 RETURNS boolean
 LANGUAGE internal
 IMMUTABLE
AS $function$charge$function$;
----
CREATE OR REPLACE FUNCTION country_gt(country, country)
 RETURNS boolean
 LANGUAGE internal
 IMMUTABLE
AS $function$chargt$function$;
----
CREATE OR REPLACE FUNCTION country_le(country, country)
 RETURNS boolean
 LANGUAGE internal
 IMMUTABLE
AS $function$charle$function$;
----
CREATE OR REPLACE FUNCTION country_lt(country, country)
 RETURNS boolean
 LANGUAGE internal
 IMMUTABLE
AS $function$charlt$function$;
----
CREATE OR REPLACE FUNCTION country_ne(country, country)
 RETURNS boolean
 LANGUAGE internal
 IMMUTABLE
AS $function$charne$function$;
----
CREATE OR REPLACE FUNCTION country_eq(country, country)
 RETURNS boolean
 LANGUAGE internal
 IMMUTABLE
AS $function$chareq$function$;
----
CREATE OR REPLACE FUNCTION country_send(country)
 RETURNS bytea
 LANGUAGE c
 IMMUTABLE STRICT
AS '$libdir/country', $function$country_send$function$;
----
CREATE OR REPLACE FUNCTION country_recv(internal)
 RETURNS country
 LANGUAGE c
 IMMUTABLE STRICT
AS '$libdir/country', $function$country_recv$function$;
----
CREATE OR REPLACE FUNCTION country_out(country)
 RETURNS cstring
 LANGUAGE c
 IMMUTABLE STRICT
AS '$libdir/country', $function$country_out$function$;
----
CREATE OR REPLACE FUNCTION country_in(cstring)
 RETURNS country
 LANGUAGE c
 IMMUTABLE STRICT
AS '$libdir/country', $function$country_in$function$;
----
CREATE OR REPLACE FUNCTION hash_country(country)
 RETURNS integer
 LANGUAGE internal
 IMMUTABLE
AS $function$hashchar$function$;
