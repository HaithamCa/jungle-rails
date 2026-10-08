#!/usr/bin/env bash
# exit on error
set -o errexit

# Allow Gemfile changes in deployment
bundle config set --local deployment 'false'
bundle config set --local path 'vendor/bundle'
bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate
bundle exec rake db:seed
