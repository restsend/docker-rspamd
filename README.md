# docker-rspamd

Dockerized version of rspamd, based on Alpine

## Quick start

1.build docker image

```bash
docker build -t restsend/rspamd .
```

2.run docker container

```bash
docker run -d --name rspamd -p 11332:11332 -p 11333:11333 -p 11334:11334 restsend/rspamd
```

> Need to wait for the server to start up.

3.check spam email

```bash
curl --data-binary @- http://localhost:11333/symbols < example.eml
```

4.visit the web interface: [http://localhost:11334](http://localhost:11334)

- default password: `rspamd`

## Expose ports

By default,

- the Rspamd controller worker listens on port `11334`
- and the proxy worker uses port `11332`
