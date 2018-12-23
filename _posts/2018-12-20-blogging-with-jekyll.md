---
layout: post
date: 2018-12-20 23:56
title:  "Blogging with Jekyll"
category: 
- jekyll
- guide
---

While I've been a bit cautious about starting this and it's taken quite longer than intended, everything has to start somewhere so I might as well kick it off here. Bringing up a blog was something that's been on my mind for a bit as a means of collecting thoughts and finding ways to best discuss the projects that I'm working on in my personal time although I wanted to make sure that I put in a little bit of work and was able to do it the right way.

I've always personally used WordPress for personal projects and in some cases, it's the right tool for the job. As fantastic as WordPress is, I'm not sure that it's necessary to have that much going on behind the scenes to run a simple blog with write-ups of projects. It seemed time to check out a couple different options for static site generation. Originally, I was looking at <a href="https://blog.getpelican.com/">Pelican</a> as an option although after experimenting with it, I was left wanting a bit more. It has some nice deployment tools rolled in but having to create a virtualenv and move that around to push out the site wasn't entirely ideal.
<!--more-->
Then came <a href="https://jekyllrb.com/">Jekyll</a>. Let me preface this with how I know almost nothing about Ruby. I had equally an uncomfortable time thinking about how to push out Jekyll sites from a local environment but then reframed the way I was thinking about it when I saw <a href="https://jekyllrb.com/docs/continuous-integration/travis-ci/">Jekyll's own documentation on Continuous Integration with Travis-CI</a>. Using this, I can simply push new posts out to a GitHub repository which is in turn compiled using Jekyll's standard methods with Travis-CI and pushed out to my webserver.

After grabbing a theme and creating the repository on GitHub, the mission became interpreting how to build a travis.yml that works with a respective set of scripts. To understand how the process worked, I slowly built up functionality in the Travis file. Starting with compiling the files and being sure that there wasn't an issue that would later need to be pulled apart seemed ideal resulting in the following YAML file with guidance from Jekyll's documentation:

{% highlight yaml linenos %}
language: ruby
rvm:
- 2.4.1
install:
- bundle install
- gem install jekyll
- gem install html-proofer
branches:
  only:
  - master
env:
  global:
  - NOKOGIRI_USE_SYSTEM_LIBRARIES=true
notifications:
  email:
    recipients:
    - garrett@jansen.sh
    on_success: never
    on_failure: always
sudo: false
cache: bundler
before_script:
- cd $TRAVIS_BUILD_DIR
- chmod +x _scripts/build.sh
script: bash _scripts/build.sh
{% endhighlight %}

The biggest roadblock along the way was something as innocuous as the change directory command in the before_script section. Without it, nothing was being generated and I wasn't sure why. After reviewing some of the error outputs, I was able to catch the simple mistake, toss in the correct entry and then get us rolling.

Finally, I just had to create a script that utilized the environment created by Travis-CI and use it to compile our site so it can be prepared for moving out. As seen above, there's a small shell script located in the `_scripts` directory that contains the magic incantation to make Jekyll come together. I opted out of using a single command in the Jekyll file largely to maintain a bit of flexibility and roll in small quality-of-life improvements like <a href="https://github.com/gjtorikian/html-proofer">HTML-Proofer</a>. If I want to modify the build process, I can simply update the shell script and not need to create a sprawling .travis.yml file. 

{% highlight bash linenos %}
#!/usr/bin/env bash
set -e

bundle exec jekyll build
{% endhighlight %}

This makes a relatively easy compiler that runs on Travis-CI, enabling me to commit new posts as markdown files that rebuild the entire site. I'll touch a bit more on the magic that facilitates the push out to my webserver in another post so I can keep this simple. Until then.
