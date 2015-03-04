#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

AUTHOR = u'Matthieu Bruneaux'
SITENAME = u'Roscoff course 2015 - RAD tags'
SITEURL = 'http://mdjbru-teaching-material.github.io/roscoff-RAD-tags-course-2015'

PATH = 'content'

TIMEZONE = 'Europe/Paris'

DEFAULT_LANG = u'en'

# Feed generation is usually not desired when developing
FEED_ALL_ATOM = None
CATEGORY_FEED_ATOM = None
TRANSLATION_FEED_ATOM = None
AUTHOR_FEED_ATOM = None
AUTHOR_FEED_RSS = None

# Blogroll
# LINKS = (('Pelican', 'http://getpelican.com/'),
#          ('Python.org', 'http://python.org/'),
#          ('Jinja2', 'http://jinja.pocoo.org/'),
#          ('You can modify those links in your config file', '#'),)

# Social widget
# SOCIAL = (('You can add links in your config file', '#'),
#           ('Another social link', '#'),)

DEFAULT_PAGINATION = 10

# Uncomment following line if you want document-relative URLs when developing
#RELATIVE_URLS = True

# Theme
#THEME = "../pelican-themes/pelican-mockingbird"
THEME = "themes/notmyidea_custom"

# No cache
LOAD_CONTENT_CACHE = False

# Paths
STATIC_PATHS=["resources"]

# http://pirsquared.org/blog/pelican-transition.html#enabling-table-of-contents-for-posts
#MD_EXTENSIONS =  [ 'toc', 'codehilite','extra']
