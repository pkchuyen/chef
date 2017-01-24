#!/usr/bin/env bash

# Usage: ./deploy.sh local | [host]

# argument requirement check
# require at least 1 arg to detect script running at localhost or remotehost
if [ $# -eq 0 ]
  then
    echo -e "No arguments supplied, require at least one argument
Example:
    $(basename $0) \t local \t\t to setup chef-solo locally
    $(basename $0) \t <hostname> \t to setup chef-solo remotely"
    exit;
fi

# Set proper _PATH dir base on working environment
case $1 in 
    local)
        export _PATH=$PWD
        source $_PATH/install.sh
    ;;
    remote)
        export _PATH=/home/deployuser/chef
        export _REMOTEHOST="${2:-deployuser@<default-hostname>}"
        chmod 0600 /var/jenkins_home/workspace/deploy.live/key/deployuser
        ssh -i /var/jenkins_home/workspace/deploy.live/key/deployuser deployuser@$_REMOTEHOST sudo /home/deployuser/chef/install.sh
    ;;
    *)
        echo "Wrong argurments."
        exit;
    ;;
esac
