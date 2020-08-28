#!/usr/bin/env bash

# Assorted troubleshooting of Travis errors
ls -larth /home/travis/build/jansendotsh/website/
find /home/travis/build/ -type f -name "index.html" 

rsync -r --delete-after --quiet $TRAVIS_BUILD_DIR/_site/ deploy@dream.jansen.sh:/usr/share/nginx/blog/
ssh deploy@dream.jansen.sh echo "Most recent successful deployment: $TRAVIS_BUILD_ID"
