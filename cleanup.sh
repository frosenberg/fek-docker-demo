#!/bin/sh

TMP_FILE=".containers"

if [ ! -e "${TMP_FILE}" ]
then
  echo "Nothing to do ... exiting"
  exit 0
fi

IDS=`cat ${TMP_FILE} | xargs`
docker rm -f ${IDS}

if [ $? == 0 ]
then
  rm $TMP_FILE
fi