#/bin/bash

rsync -r --delete-after --quiet $TRAVIS_BUILD_DIR/_site deploy@69.164.214.227:/data/nginx/blog
ssh deploy@69.164.214.227 echo "Most recent successful deployment: $TRAVIS_BUILD_ID"
