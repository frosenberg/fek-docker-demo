FROM ubuntu:12.04

MAINTAINER frosenberg "https://github.com/frosenberg"

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y 
RUN apt-get install apt-utils curl libcurl4-gnutls-dev build-essential -y
##
# Ideally we should run this script but sudo causes issues with docker 
# RUN curl -L http://toolbelt.treasuredata.com/sh/install-ubuntu-precise.sh | sh 
##
RUN curl http://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add -
RUN echo "deb http://packages.treasuredata.com/precise/ precise contrib" > /etc/apt/sources.list.d/treasure-data.list
RUN apt-get update -y # run again to update sources
RUN apt-get install -y --force-yes td-agent

RUN /etc/init.d/td-agent restart
RUN /usr/lib/fluent/ruby/bin/fluent-gem install fluent-plugin-elasticsearch

EXPOSE 8888
# CMD ["/usr/local/bin/run"]
