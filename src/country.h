#ifndef COUNTRY_H
#define COUNTRY_H

#include "postgres.h"
#include "fmgr.h"
#include "libpq/pqformat.h"
#include "countries.h"


typedef uint8 country;

#define PG_RETURN_UINT8(x) return UInt8GetDatum(x)
#define PG_GETARG_UINT8(x) DatumGetUInt8(PG_GETARG_DATUM(x))
Datum country_in(PG_FUNCTION_ARGS);
Datum country_out(PG_FUNCTION_ARGS);
Datum country_recv(PG_FUNCTION_ARGS);
Datum country_send(PG_FUNCTION_ARGS);

#endif // COUNTRY_H
