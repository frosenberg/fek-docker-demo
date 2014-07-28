FROM ubuntu
MAINTAINER Florian Rosenberg "https://github.com/frosenberg"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
      apt-utils \
      curl 
RUN curl http://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add -
RUN echo "deb http://packages.treasuredata.com/precise/ precise contrib" > /etc/apt/sources.list.d/treasure-data.list

RUN apt-get update && apt-get install -y \
      apache2 \
      td-agent \
      supervisor

RUN mkdir /var/lock/apache2 # fails to start without this line
RUN mkdir /var/run/apache2 # fails to start without this line

ADD config/td-agent.conf /etc/td-agent/td-agent.conf
ADD config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Please override accordingly with docker run -e
ENV LOG_AGGR_HOST1 log-aggr1.dev.docker
ENV LOG_AGGR_HOST2 log-aggr2.dev.docker

EXPOSE 80
CMD ["/usr/bin/supervisord"]