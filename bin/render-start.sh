#!/usr/bin/env bash
# exit on error
set -o errexit

# Ruby on Rails (Thruster handles static assets, compression, and caching)
bundle exec thrust ./bin/rails server
