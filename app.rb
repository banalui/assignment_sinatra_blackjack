require "sinatra"
require "sinatra/reloader" if development?
require "erb"
require "bundler/setup"

get '/' do	
  	erb :home
end