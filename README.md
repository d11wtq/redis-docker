# Docker container for Redis

This builds a docker container running Redis on port 6379, with optional host
persistence.

## Testing

To test that the container works, start it without any special options, then
make sure you can talk to it on port 6379.

```
-bash$ docker run -d -p 6379:6379 d11wtq/redis
abcdef1234567890abcdef1234567890abcdef1234567890ab

-bash$ nc -z localhost 6379
Connection to localhost port 6379 [tcp] succeeded!
```

## Configuration

This is a very simple container. Redis stores its data under /redis/data and
uses an extremely minimal configuration file from /redis/redis.conf.

It is expected that you mount /redis/data as a volume if you require long-lived
persistence on the host.

Redis runs under the user 'default'. Logs are written to stdout/stderr.

You may change the configuration by mounting /redis/redis.conf (docker allows
you to mount files with `-v`).

## Example Usage

The following shows an example of running redis with data persisted on the
host.

```
-bash$ docker run -d \
>   --name redis \
>   -v $(pwd)/data:/redis/data \
>   d11wtq/redis
abcdef1234567890abcdef1234567890abcdef1234567890ab
-bash$
```

The shared volume data/ is initially empty, but will be initialized by the
container.

### Client Access

If you need to try something in the redis-cli client, ths easiest way to do
this is to use `docker exec`:

```
-bash$ docker exec -ti redis redis-cli
127.0.0.1:6379> PING
PONG
127.0.0.1:6379>
```
