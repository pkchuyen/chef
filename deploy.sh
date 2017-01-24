#!/usr/bin/env bash

# Usage: ./deploy.sh local | [host]

if [ $# -eq 0 ]
  then
    echo -e "No arguments supplied, require at least one argument
Example:
    $(basename $0) \t local \t\t to setup chef-solo locally
    $(basename $0) \t <hostname> \t to setup chef-solo remotely"
    exit;
fi

if [[ $1 == 'local' ]]; then
    echo "Setup Chef locally:"
    sudo bash install.sh
else
    host="${1:-user@<default-hostname>}"

    echo "TODO: implement feature to allow remote setup."
    exit;
fi 

