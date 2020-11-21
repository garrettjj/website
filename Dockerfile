FROM jekyll/jekyll:3.8.4

RUN apk add --update --no-cache build-base imagemagick6 imagemagick6-c++ \
    imagemagick6-dev imagemagick6-libs
