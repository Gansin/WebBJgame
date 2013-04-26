require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

set :sessions, true

get '/inline' do
	"hi, directly from the action"
end


