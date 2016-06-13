#!/bin/bash

GET_NUMBERS_USAGE="get_numbers [OFFSET] [LIMIT]"
ADD_FAVORITE_USAGE="add_favorite [NUMBER]"
REMOVE_FAVORITE_USAGE="remove_favorite [NUMBER]"
USAGE="$0 COMMAND ARGS

Commands:
  $GET_NUMBERS_USAGE
  $ADD_FAVORITE_USAGE
  $REMOVE_FAVORITE_USAGE

You also need to set FIZZBUZZ_SERVER_URL in your
environment to point at your fizzbuzz server
"

usage_exit() {
    echo "USAGE:" "$1"
    exit 0
}

get_numbers() {
    curl -X GET -H "Accept: application/json" \
	"$FIZZBUZZ_SERVER_URL/?offset=$1&limit=$2"
}

handle_favorite() {
    curl -X "$1" -H "Accept: application/json" \
	-H "Content-Type: application/json" \
	"$FIZZBUZZ_SERVER_URL/favorites/" \
	-d "{\"number\": $2}"
}

add_favorite() {
    if [ $# -ne 2 ]; then
	usage_exit "$ADD_FAVORITE_USAGE"
    fi
    handle_favorite POST "$1"
}

remove_favorite() {
    if [ $# -ne 2 ]; then
	usage_exit "$REMOVE_FAVORITE_USAGE"
    fi
    handle_favorite DELETE "$1"
}

if [ $# -eq 0 ]; then
    usage_exit "$USAGE"
fi

if [ -z $FIZZBUZZ_SERVER_URL ]; then
    (>&2 echo "You need to set FIZZBUZZ_SERVER_URL in your environment")
    exit
fi

case $1 in
    "get_numbers")
	get_numbers "$2" "$3"
	;;
    "add_favorite")
	add_favorite "$2"
	;;
    "remove_favorite")
	remove_favorite "$2"
	;;
    *)
	(>&2 printf "unknown command: %s\n" "$1")
	usage_exit "$USAGE"
	;;
esac 
