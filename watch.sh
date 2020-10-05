#!/bin/sh

SCRIPT=$(realpath $0)
SCRIPT_DIR=$(dirname $SCRIPT)
WATCH_DIR="$SCRIPT_DIR/wav"
mkdir -p "$WATCH_DIR"

inotifywait -m "$WATCH_DIR" -e 'CLOSE_WRITE' --format '%w%f' |
while read filepath; do
  $SCRIPT_DIR/encode.sh "$filepath"
done

