FROM ubuntu:12.04

MAINTAINER frosenberg "https://github.com/frosenberg"

RUN curl -L http://toolbelt.treasuredata.com/sh/install-ubuntu-precise.sh | sh 
RUN /etc/init.d/td-agent restart
RUN /usr/lib/fluent/ruby/bin/fluent-gem install fluent-plugin-elasticsearch

ADD run.sh /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

EXPOSE 8888
CMD ["/usr/local/bin/run"]
