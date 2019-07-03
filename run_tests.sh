#!/usr/bin/env bash

set -ux
status=0

# global exports
export PGPORT=55435

# build extension
make install

# initialize database
initdb -D $PGDATA

# change PG's config
echo "port = $PGPORT" >> $PGDATA/postgresql.conf

# start cluster
pg_ctl start -l /tmp/postgres.log -w || status=$?

# something's wrong, exit now!
if [ $status -ne 0 ]; then cat /tmp/postgres.log; exit 1; fi

# run regression tests
export PG_REGRESS_DIFF_OPTS="-w -U3" # for alpine's diff (BusyBox)
make installcheck || status=$?

# show diff if it exists
if [ -f regression.diffs ]; then cat regression.diffs; fi

# something's wrong, exit now!
if [ $status -ne 0 ]; then exit 1; fi

set +ux

