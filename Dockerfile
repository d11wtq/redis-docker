# Dockerfile for a redis-server container.
#
# Runs redis-server on port 6379.

FROM       d11wtq/ubuntu
MAINTAINER Chris Corbyn <chris@w3style.co.uk>

RUN sudo touch /var/log/redis.log
RUN sudo mkdir /var/lib/redis
RUN sudo chown default: /var/lib/redis /var/log/redis.log

ENV REDIS_VER 2.8.4
ENV REDIS_DIR redis-$REDIS_VER
ENV REDIS_PKG $REDIS_DIR.tar.gz

ADD http://download.redis.io/releases/$REDIS_PKG /tmp/$REDIS_PKG

RUN cd /tmp;                                                  \
    sudo chown default: *.tar.gz;                             \
    tar xvzf *.tar.gz; rm -f *.tar.gz;                        \
    cd $REDIS_DIR;                                            \
    make && make install;                                     \
    cd; rm -rf /tmp/$REDIS_DIR

ADD redis.conf /etc/redis.conf

EXPOSE 6379

CMD [ "/usr/bin/sudo", "su", "default", "-c", \
      "/usr/local/bin/redis-server /etc/redis.conf" ]
