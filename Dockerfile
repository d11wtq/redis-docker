# Dockerfile for a redis-server container.
#
# Runs redis-server on port 6379.

FROM       d11wtq/ubuntu
MAINTAINER Chris Corbyn <chris@w3style.co.uk>

ENV REDIS_VER 2.8.4
ENV REDIS_DIR redis-$REDIS_VER
ENV REDIS_PKG $REDIS_DIR.tar.gz

RUN cd /tmp;                                                  \
    curl -LO http://download.redis.io/releases/$REDIS_PKG;    \
    tar xvzf *.tar.gz; rm -f *.tar.gz;                        \
    cd $REDIS_DIR;                                            \
    make && make install;                                     \
    cd; rm -rf /tmp/$REDIS_DIR

ADD redis /redis
RUN sudo chown -R default: /redis/data

EXPOSE 6379

CMD [ "/usr/local/bin/redis-server", "/redis/redis.conf" ]
