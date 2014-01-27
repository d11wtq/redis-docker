# Dockerfile for a redis-server container.
#
# Runs redis-server on port 6379.

FROM       ubuntu
MAINTAINER Chris Corbyn

ENV REDIS_VER 2.8.4
ENV REDIS_DIR redis-$REDIS_VER
ENV REDIS_PKG $REDIS_DIR.tar.gz

ADD http://download.redis.io/releases/$REDIS_PKG /tmp/$REDIS_PKG

RUN useradd redis
RUN apt-get install -qq -y build-essential
RUN cd /tmp; tar xvzf $REDIS_PKG; rm $REDIS_PKG
RUN cd /tmp/$REDIS_DIR; make && make install; rm -rf /tmp/$REDIS_DIR

RUN touch /var/log/redis.log; chown redis: /var/log/redis.log
RUN mkdir /var/lib/redis; chown redis: /var/lib/redis

ADD redis.conf /etc/redis.conf

EXPOSE 6379

CMD ["/bin/su", "redis", "-c", "/usr/local/bin/redis-server /etc/redis.conf"]
