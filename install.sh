#!/usr/bin/env bash
set -x

# This runs as root on the server
# Chef-solo install
echo "installing Chef"
command -v chef-solo >/dev/null 2>&1 || { echo >&2 "I require chef but it's not installed.  Intalling Chef-solo."; sudo bash install/install.sh; }

echo "installing Ruby"
command -v ruby >/dev/null 2>&1 || { echo >&2 "I require chef but it's not installed.  Intalling Chef-solo."; sudo yum install -y ruby rubygems; sudo gem install bundle;}
command -v make >/dev/null 2>&1 || { echo >&2 "I require bundle but it's not installed.  Intalling Bundle."; yum install -y make gcc; sudo gem install bundle; sudo /usr/local/bin/bundle install; }
command -v /usr/local/bin/bundle >/dev/null 2>&1 || { echo >&2 "I require bundle but it's not installed.  Intalling Bundle."; sudo gem install bundle; sudo /usr/local/bin/bundle install; }

chef-solo -c solo.rb -j solo.json