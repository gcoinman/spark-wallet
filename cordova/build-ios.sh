#!/bin/bash
set -xeo pipefail

[[ -d node_modules ]] || npm install

export BUILD_TARGET=cordova
export DEST=`pwd`/www

mkdir -p $DEST && rm -rf $DEST/*

[ -z "$SKIP_CLIENT" ] && (cd ../client && npm run dist)

version=`node -p 'require("../package").version'`

cordova prepare
cordova build ios "$@"
