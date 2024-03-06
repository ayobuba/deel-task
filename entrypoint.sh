#!/bin/bash

set -e

# Run database migrations
flask db upgrade

# Run the command provided as arguments to this script
exec "$@"