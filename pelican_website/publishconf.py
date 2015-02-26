#!/usr/bin/env python
# -*- coding: utf-8 -*- #
from __future__ import unicode_literals

# This file is only used if you use `make publish` or
# explicitly specify it as your config file.

import os
import sys
sys.path.append(os.curdir)
from pelicanconf import *

SITEURL = 'http://mdjbru-teaching-material.github.io/roscoff-RAD-tags-course-2015'
RELATIVE_URLS = True

DELETE_OUTPUT_DIRECTORY = True

# Org reader
#PLUGIN_PATHS = ["./org_reader"]
#PLUGINS = ["org_reader"]
#ORG_READER_EMACS_LOCATION = "/usr/bin/emacs"
#PLUGIN_PATHS = ["./extract_toc"]
#PLUGINS = ["extract_toc"]
