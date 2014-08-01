#!/bin/sh

source settings.sh

TMP_FILE=".containers"

if [ -e "${TMP_FILE}" ]
then
  echo "Please call cleanup.sh first to stop and remove existing containers."
  exit 1
fi

ES_CONTAINER=`docker run -d --name es frosenberg/elasticsearch`
echo $ES_CONTAINER >> $TMP_FILE

KIBANA_CONTAINER=`docker run -d -e "ES_HOST=elasticsearch.${ENV_NAME}.${DOMAIN_NAME}" --name kibana frosenberg/kibana`
echo $KIBANA_CONTAINER >> $TMP_FILE

# start fluent aggregators
for fid in {1..2}
do
  FLUENTD_CONTAINER=`docker run -d -e "ES_HOST=elasticsearch.${ENV_NAME}.${DOMAIN_NAME}" --name faggr${fid} frosenberg/fluentd`
  echo $FLUENTD_CONTAINER >> $TMP_FILE
done

APACHE_CONTAINER=`docker run -d -e "LOG_AGGR_HOST1=faggr1.fluentd.${ENV_NAME}.${DOMAIN_NAME}" -e "LOG_AGGR_HOST2=faggr2.fluentd.${ENV_NAME}.${DOMAIN_NAME}" --name apache2 frosenberg/apache2`
echo $APACHE_CONTAINER >> $TMP_FILE