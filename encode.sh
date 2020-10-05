#!/bin/sh

SCRIPT=$(realpath $0)
SCRIPT_DIR=$(dirname $SCRIPT)

LOG_DIR=$SCRIPT_DIR/log
mkdir -p $LOG_DIR

encode() {
  INPUT_PATH=$1
  INPUT_FILE=$(basename "$INPUT_PATH")
  INPUT_DIR=$(dirname "$INPUT_PATH")
  NOEXT=${INPUT_FILE%.*}
  ALBUM=$(echo $NOEXT | awk -F '--' '{print $1;}')
  TITLE=$(echo $NOEXT | awk -F '--' '{print $2;}')

  mkmp3 &
  mkogg &
  mkflac &
}

mkoutput() {
  DIR=$SCRIPT_DIR/$1/$ALBUM
  [ -d $DIR ] || mkdir -p $DIR
  export OUTPUT_PATH="$DIR/$TITLE.$1"
}

mkmp3() {
  mkoutput 'mp3'
  LOG_FILE=$LOG_DIR/mp3.log
  echo "$OUTPUT_PATH" >> $LOG_FILE
  echo "" >> $LOG_FILE
  lame "$INPUT_PATH" "$OUTPUT_PATH" >> $LOG_FILE 2>&1
  echo "" >> $LOG_FILE
  echo "" >> $LOG_FILE
}

mkogg() {
  mkoutput 'ogg'
  LOG_FILE=$LOG_DIR/ogg.log
  echo "$OUTPUT_PATH" >> $LOG_FILE
  echo "" >> $LOG_FILE
  oggenc "$INPUT_PATH" -o "$OUTPUT_PATH" >> $LOG_FILE 2>&1
  echo "" >> $LOG_FILE
  echo "" >> $LOG_FILE
}

mkflac() {
  mkoutput 'flac'
  LOG_FILE=$LOG_DIR/flac.log
  echo "$OUTPUT_PATH" >> $LOG_FILE
  echo "" >> $LOG_FILE
  flac "$INPUT_PATH" -o "$OUTPUT_PATH" >> $LOG_FILE 2>&1
  echo "" >> $LOG_FILE
  echo "" >> $LOG_FILE
}

while [ $# -gt 0 ]; do
  encode "$1"
  shift
done

