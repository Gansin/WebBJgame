require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

set :sessions, true

get '/inline' do   
	"this is the inline msample"
end

get '/template' do
	erb :ganstemplate
end

get '/nested_template' d  o
  erb :"/users/profile"
end