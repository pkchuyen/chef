#!/usr/bin/env bash
set -x
set -e

# This runs as root on the server
# Chef-solo install
echo "installing Chef"
command -v chef-solo >/dev/null 2>&1 || { echo >&2 "I require chef but it's not installed.  Intalling Chef-solo."; sudo bash install/install.sh; }

echo "installing Ruby"
command -v ruby >/dev/null 2>&1 || { echo >&2 "I require chef but it's not installed.  Intalling Chef-solo."; sudo yum install -y ruby rubygems; sudo gem install bundle;}
command -v make >/dev/null 2>&1 || { echo >&2 "I require bundle but it's not installed.  Intalling Bundle."; yum install -y make gcc; sudo gem install bundle; sudo /usr/local/bin/bundle install; }
command -v /usr/local/bin/bundle >/dev/null 2>&1 || { echo >&2 "I require bundle but it's not installed.  Intalling Bundle."; sudo gem install bundle; sudo /usr/local/bin/bundle install; }

# check environment _PATH to detect local or remote deploy to get the proper _PATH
[[ ! -n $_PATH ]] && export _PATH=${1} || :

# execute chef-solo to apply cookbook
chef-solo -c $_PATH/solo.rb -j $_PATH/solo.json

## --- Reload Web App django
# for i in $(ps aux|grep python|grep runserver|awk {'print $2'});do kill -9 $i;done
# /bin/python /app/public/greetings/manage.py runserver 0.0.0.0:8000 &