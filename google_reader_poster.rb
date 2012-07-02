require "rubygems"
require "bundler/setup"

require 'mechanize'
require 'sinatra'

BLOG_URL = ENV['BLOG_URL']
BLOG_USERNAME = ENV['BLOG_USERNAME']
BLOG_PASS = ENV['BLOG_PASS']
AUTH_TOKEN = ENV['AUTH_TOKEN']

get '/google_reader_post' do

  if AUTH_TOKEN == params[:auth_token]
    agent = WWW::Mechanize.new
    #agent = Mechanize.new
    page =  agent.get("#{BLOG_URL}/wp-admin/")
    page.form('loginform').field('log').value = BLOG_USERNAME
    page.form('loginform').field('pwd').value = BLOG_PASS
    page = page.form('loginform').submit

        page = agent.get("#{BLOG_URL}/wp-admin/post-new.php")
        page.form('post').field('content').value = %Q(<a href="#{params[:url]}">#{params[:title]}</a>)

        #button = page.form('post').button('save-post')
        button = page.form('post').button('publish')

        page.form('post').submit(button)
    "source: #{params[:source]}\ntitle: #{params[:title]}\nurl: #{params[:url]}"
  else
    ":("
  end
end
