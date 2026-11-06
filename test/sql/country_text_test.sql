BEGIN;
CREATE EXTENSION country;

CREATE TEMP TABLE country_names (code country, name text, common_name text);
INSERT INTO country_names VALUES
    ('cn', 'China', 'China'),
    ('de', 'Germany', 'Germany'),
    ('ax', 'Åland Islands', 'Åland Islands'),
    ('ci', 'Côte d''Ivoire', 'Ivory Coast'),
    ('gb', 'United Kingdom of Great Britain and Northern Ireland', 'Great Britain'),
    ('la', 'Lao People''s Democratic Republic', 'Laos'),
    ('zz', 'Unknown', 'Unknown');

-- Text values must contain only the name bytes, without a C terminator.
-- Check common-name overrides as well as the fallback to country_name.
SELECT code, kind,
       actual = expected AS equal,
       char_length(actual) = char_length(expected) AS chars,
       octet_length(actual) = octet_length(expected) AS bytes,
       textsend(actual) = textsend(expected) AS payload
FROM country_names
CROSS JOIN LATERAL (VALUES
    ('name', country_name(code), name),
    ('common', country_common_name(code), common_name)
) AS names(kind, actual, expected)
ORDER BY code, kind;

-- The C string used by country_out and country_send still needs its terminator.
SELECT code, char_length(code::text) AS chars, octet_length(code::text) AS bytes,
       code::text::country = code AS roundtrip,
       encode(country_send(code), 'hex') AS binary
FROM country_names
ORDER BY code;

ROLLBACK;
