#!/bin/bash

set -e # Exit on any errors

# Get the directory of this script
# https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Read the username and password
source .env

# Parse the version from the TOML file
VERSION=$(sed -n 's/^.*version = "\(.*\)"/\1/p' pyproject.toml)

# Commit
git add -A
git commit -a -m "$VERSION"
git push

# From: https://levelup.gitconnected.com/how-to-publish-a-python-command-line-application-to-pypi-5b97a6d586f1
poetry publish --username $PYPI_USERNAME --password $PYPI_PASS --build
