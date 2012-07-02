require "rubygems"
require "bundler/setup"

require 'mechanize'
require 'sinatra'

require './google_reader_poster.rb'

#  log = File.new("sinatra.log", "a+")
#  $stderr.reopen(log)
run Sinatra::Application
