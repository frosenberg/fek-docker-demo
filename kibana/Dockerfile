FROM ubuntu
MAINTAINER Florian Rosenberg "https://github.com/frosenberg"

RUN DEBIAN_FRONTEND=noninteractive 
RUN apt-get update -y && apt-get install -y wget nginx-full
RUN (cd /tmp && wget --no-check-certificate https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz -O pkg.tar.gz && tar zxf pkg.tar.gz && cd kibana-* && cp -rf ./* /usr/share/nginx/html/)
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD run.sh /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN rm -rf /tmp/*

EXPOSE 80
CMD ["/usr/local/bin/run"]