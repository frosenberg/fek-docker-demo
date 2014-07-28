#!/bin/sh

ENV_NAME='dev'
DOMAIN_NAME='docker'
TMP_FILE=".containers"

if [ -e "${TMP_FILE}" ]
then
  echo "Please call cleanup.sh first to stop and remove existing containers."
  exit 1
fi

# start DNS server and service discovery containers

DNS_CONTAINER=`docker run -d -p 172.17.42.1:53:53/udp --name skydns crosbymichael/skydns -nameserver 8.8.8.8:53 -domain docker`
echo $DNS_CONTAINER >> $TMP_FILE
SKYDOCK_CONTAINER=`docker run -d -v /var/run/docker.sock:/docker.sock --name skydock crosbymichael/skydock -ttl 30 -environment ${ENV_NAME} -s /docker.sock -domain ${DOMAIN_NAME} -name skydns`
echo $SKYDOCK_CONTAINER >> $TMP_FILE

ES_CONTAINER=`docker run -d --name es frosenberg/elasticsearch`
echo $ES_CONTAINER >> $TMP_FILE

KIBANA_CONTAINER=`docker run -d --name kibana frosenberg/kibana`
echo $KIBANA_CONTAINER >> $TMP_FILE

# start fluent aggregators
for fid in {1..2}
do
  FLUENTD_CONTAINER=`docker run -d -e "ES_HOST=es.${ENV_NAME}.${DOMAIN_NAME}" --name faggr${fid} frosenberg/fluentd`
  echo $FLUENTD_CONTAINER >> $TMP_FILE
done

APACHE_CONTAINER=`docker run -d -e "LOG_AGGR_HOST1=faggr1.fluentd.${ENV_NAME}.${DOMAIN_NAME} LOG_AGGR_HOST2=faggr2.fluentd.${ENV_NAME}.${DOMAIN_NAME}" --name apache2 frosenberg/apache2`
echo $APACHE_CONTAINER >> $TMP_FILE