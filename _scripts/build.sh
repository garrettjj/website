#!/usr/bin/env bash
set -e

bundle exec jekyll build
#bundle exec htmlproofer --empty_alt_ignore --disable-external ./_site
