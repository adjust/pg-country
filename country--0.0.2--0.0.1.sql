UPDATE pg_catalog.pg_type typ
    SET typdefault=''
FROM pg_catalog.pg_extension ext,
pg_depend dep
WHERE dep.refobjid = ext.oid
AND dep.objid = typ.oid
AND ext.extname='country'
AND typ.typname='country';