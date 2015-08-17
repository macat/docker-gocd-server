FROM java:openjdk-7-jre
MAINTAINER Attila Maczak attila@maczak.hu

RUN apt-get update -y && apt-get install -y git && rm -rf /var/lib/apt/lists/*

RUN wget -O /tmp/go-server.deb http://download.go.cd/gocd-deb/go-server-15.2.0-2248.deb
RUN dpkg -i /tmp/go-server.deb
RUN rm /tmp/go-server.deb

EXPOSE 8153
EXPOSE 8154

RUN mkdir -p /var/lib/go-server/plugins/external
RUN cd /var/lib/go-server/plugins/external && \
    wget https://github.com/srinivasupadhya/gocd-build-status-notifier/releases/download/1.1/github-pr-status-1.1.jar &&\
    wget https://github.com/ashwanthkumar/gocd-build-github-pull-requests/releases/download/1.2/github-pr-poller-1.2.jar
RUN chown -R go:go /var/lib/go-server

CMD /etc/init.d/go-server start && tail -f /var/log/go-server/go-server.log
