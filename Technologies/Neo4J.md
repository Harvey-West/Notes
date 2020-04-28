# Neo4j

Neo4J workloads tend significantly toward random reads.
SSD over spinning disks (low average seek time).
Requires JDK.

Filesystem must suport flush (fsync, fdatasync).

## Docker

Default enables remote access via HTTP, HTTPS and Bolt.

### Ports

- 7474 for HTTP
- 7473 for HTTPS
- 7687 for Bolt

### Volumes

Docker images exposes the following volumes:

- /conf
- /data
- /import
- /logs
- /metrics
- /plugins
- /ssl

### Page cache

`NEO4J_dbms_memory_pagecache_size=` is the configuration value for pagecache.
`NEO4J_dbms_memory_heap_max__size=` is the configuration for heap.

The default for both is 512M. This is not suitable for production environments.

### Encryption

Docker image can expose Neo4j's native TLS suport. You provide a `/ssl` volume
with a key and certificate inside and then publish the 7473 port.
