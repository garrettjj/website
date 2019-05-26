#!/usr/bin/env bash

# Assorted troubleshooting of Travis errors
ls -larth /home/travis/build/garrettjj/website/
find /home/travis/build/ -type f -name "index.html" 

rsync -r --delete-after --quiet $TRAVIS_BUILD_DIR/_site/ deploy@internal.web.jansen.sh:/data/blog/
ssh deploy@internal.web.jansen.sh echo "Most recent successful deployment: $TRAVIS_BUILD_ID"
