FROM java:openjdk-7-jre
MAINTAINER Attila Maczak attila@maczak.hu

RUN apt-get update -y && apt-get install -y git && rm -rf /var/lib/apt/lists/*

RUN wget -O /tmp/go-server.deb http://download.go.cd/gocd-deb/go-server-15.2.0-2248.deb
RUN dpkg -i /tmp/go-server.deb
RUN rm /tmp/go-server.deb

EXPOSE 8153
EXPOSE 8154

RUN mkdir -p /var/lib/go-server/plugins/external
RUN mkdir -p /var/lib/go-server/db
RUN chown -R go:go /var/lib/go-server

VOLUME /var/lib/go-server/plugins/external
VOLUME /var/lib/go-server/db
VOLUME /etc/go
VOLUME /var/go

CMD /etc/init.d/go-server start && tail -f /var/log/go-server/go-server.log
