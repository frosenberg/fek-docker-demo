FROM ubuntu:14.04
MAINTAINER Florian Rosenberg "https://github.com/frosenberg"

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y \
      apt-utils \
      curl \
      libcurl4-gnutls-dev \
      build-essential 

##
# Ideally we should run this script but sudo causes issues with docker 
# RUN curl -L http://toolbelt.treasuredata.com/sh/install-ubuntu-precise.sh | sh 
##
RUN curl http://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add -
RUN echo "deb http://packages.treasuredata.com/precise/ precise contrib" > /etc/apt/sources.list.d/treasure-data.list
RUN apt-get update && apt-get install -y td-agent

RUN /usr/lib/fluent/ruby/bin/fluent-gem install fluent-plugin-elasticsearch

ADD config/td-agent.conf /etc/td-agent/td-agent.conf
RUN touch /var/log/td-agent/td-agent.log # i have seen it failng without it

ENV ES_HOST elasticsearch.dev.docker
ENV ES_PORT 9200

EXPOSE 8888 24224
CMD [ "--use-v1-config" ] 
# "-o", "/var/log/td-agent/td-agent.log"]
ENTRYPOINT ["/usr/sbin/td-agent"]