#!/bin/bash
set -e

# removes server.pid if existent
rm -f /dns_store/tmp/pids/server.pid

# exec container's main process (what's set as CMD in the Dockerfile).
exec "$@"
