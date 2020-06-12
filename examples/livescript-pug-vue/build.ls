#!/usr/bin/env lsc

{src, dest} = require 'gulp'
lsc = require 'gulp-livescript'
pug = require 'gulp-pug'

ls_to_js = -> src 'ls/*.ls' .pipe lsc bare: true .pipe dest 'js/'
pug_to_html = -> src 'index.pug' .pipe pug pretty: true .pipe dest './'

ls_to_js!
pug_to_html!
