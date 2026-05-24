#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
export SECRET_KEY_BASE=$(openssl rand -hex 64)
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate
