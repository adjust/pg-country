#!/usr/bin/env bash

set -eux

cd /repo
pg-init
build-check

set +eux

