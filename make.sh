#!/bin/bash

set -e

HOST_DIR=`pwd`
DK_DIR=/usr/src/app

ENV_BACKEND=csci-e39.herokuapp.com
ENV_PORT=3000
ENV_STUDENT_ID=`cat .id`

# REPO=tshelburne/csci-e39
# TAG=master
# IMAGE=$REPO:$TAG

# function mount() {
# 	MOUNTED=""
# 	for TARGET in "$@"; do
# 		MOUNTED="$MOUNTED -v $HOST_DIR/$TARGET:$DK_DIR/$TARGET"
# 	done
# 	echo $MOUNTED
# }

# DK_MOUNT_DEBUG=`mount build public`
# DK_MOUNT=`mount src .id dev.sqlite3 package.json package-lock.json`
# DK_ENV="-e PORT=$ENV_PORT -e STUDENT_ID=$ENV_STUDENT_ID -e DATABASE_URL=$DATABASE_URL"
# DK_PORTS="--expose $ENV_PORT -p $ENV_PORT:$ENV_PORT --expose 35729 -p 35729:35729"
# DK_DEBUG="-e DEBUG=knex:*,socket.io:*,csci-e39:*"

# supports both unix and windows
# _docker() {
# 	if hash docker 2>/dev/null; then
# 		docker "$@"
# 	else
# 		docker.exe "$@"
# 	fi
# }

function all() {
	clean
	migrate
	start
}

function clean() {
	stop
	rm -rf build node_modules public dev.sqlite3
}

function build() {
	touch dev.sqlite3
	npm install
}

function activate() {
	local ASSIGNMENT=$1
	build

	sed -i -e "s/assignments\/.*\//assignments\/$(assignment)\//g" src/ui/app.jsx.js
	sed -i -e "s/css\/.*\//css\/$(assignment)\//g" src/ui/index.pug
}

function start() {
	build
	npm start
}

# function stop() {
	# _docker stop `_docker ps -qa --filter="ancestor=$IMAGE"` || true
# }

function watch() {
	build
	npm run watch
}

function live() {
	build
	BACKEND=$ENV_BACKEND npm start
}

function migrate() {
	build
	npm run migrate
	npx knex seed:run
}

CMD=$1; shift
case $CMD in
	'test_docker') _docker -v;;
	'all') all;;
	'clean') clean;;
	'build') build;;
	'activate')
		ASSIGNMENT=$1
		activate $ASSIGNMENT;;
	'start') start;;
	'stop') stop;;
	'watch') watch;;
	'live') live;;
	'migrate') migrate;;
esac
