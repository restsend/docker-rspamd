# docker-rspamd

Dockerized version of rspamd, based on Alpine

## Quick start

1.build docker image && run docker container

```bash
docker build -t restsend/rspamd .
```

```bash
docker run -d --name rspamd -p 11332:11332 -p 11333:11333 -p 11334:11334 restsend/rspamd
```

> Need to wait for the server to start up.

2.check spam email

```bash
curl --data-binary @- http://localhost:11333/symbols < example.eml
```

3.visit the web interface: [http://localhost:11334](http://localhost:11334)

- default password: `rspamd`

## Document

### Listening interface

> Official Document: [https://rspamd.com/doc/quickstart.html#setting-listening-interface](https://rspamd.com/doc/quickstart.html#setting-listening-interface)

- `11332` - Proxy worker
- `11333` - Normal worker
- `11334` - Controller worker

### Rspamd protocol

> Official Document: [https://rspamd.com/doc/architecture/protocol.html](https://rspamd.com/doc/architecture/protocol.html)

#### Curl Example

To check a message without rspamc:

```bash
curl --data-binary @- http://localhost:11333/symbols < file.eml
```

#### Normal worker HTTP endpoints

The following endpoints are valid on the normal worker and accept POST:

- `/checkv2` - Checks message and return action

The below endpoints all use GET:

- `/ping` - Returns just a pong HTTP reply (could be used for monitoring)

#### Controller HTTP endpoints

The following endpoints are valid merely on the controller. All of these may require Password header to be sent depending on configuration (passing this as query string works too).

- `/fuzzyadd` - Adds message to fuzzy storage
- `/fuzzydel` - Removes message from fuzzy storage

These accept POST. Headers which may be set are:

- `Flag`: flag identifying fuzzy storage
- `Weight`: weight to add to hashes

- `/learnspam` - Trains bayes classifier on spam message
- `/learnham` - Trains bayes classifier on ham message
- `/checkv2` - Checks message and return action (same as normal worker)

These also accept POST. The below endpoints all use GET:

- `/errors` - Returns error messages from ring buffer
- `/stat` - Returns statistics
- `/statreset` - Returns statistics and reset countes
- `/graph?type=<hourly|daily|weekly|monthly>` - Plots throughput graph
- `/history` - Returns rolling history
- `/historyreset` - Returns rolling history and resets its elements afterwards
- `/actions` - Returns thresholds for actions
- `/symbols` - Returns symbols in metric & their scores
- `/maps` - Returns list of maps
- `/neighbours` - Returns list of known peers
- `/errors` - Returns a content of errors ring buffer
- `/getmap` - Fetches contents of map according to ID passed in Map: header
- `/fuzzydelhash` - Deletes entries from fuzzy according to content of Hash: header(s)
- `/plugins` - Returns list of plugins or plugin specific stuff
- `/ping` - Returns just a pong HTTP reply (could be used for monitoring)
- `/metrics` - Returns OpenMetrics data
