FROM ubuntu
MAINTAINER Florian Rosenberg "https://github.com/frosenberg"

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y install curl sudo openjdk-7-jre-headless
RUN curl http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb http://packages.elasticsearch.org/elasticsearch/1.2/debian stable main" >> /etc/apt/sources.list
RUN apt-get update -y && apt-get install -y elasticsearch

ADD run.sh /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

EXPOSE 9200 9300
VOLUME ["/var/lib/elasticsearch"]
CMD ["/usr/local/bin/run"]