FROM ubuntu:12:04

# general ubuntu stuff
RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install wget curl

# install java
RUN apt-get install openjdk-7-jre-headless -y

# install elasticsearch as debian package
RUN wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.2.2.deb
RUN dpkg -i elasticsearch-1.2.2.deb

# install service wrapper
RUN curl -L http://github.com/elasticsearch/elasticsearch-servicewrapper/tarball/master | tar -xz
RUN mv *servicewrapper*/service /usr/local/share/elasticsearch/bin/
RUN rm -Rf *servicewrapper*
RUN /usr/local/share/elasticsearch/bin/service/elasticsearch install
RUN ln -s `readlink -f /usr/local/share/elasticsearch/bin/service/elasticsearch` /usr/local/bin/rcelasticsearch
RUN service elasticsearch start

EXPOSE 9200
EXPOSE 9300 
