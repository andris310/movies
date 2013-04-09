require 'pry'
gem 'sinatra', '1.3.0'
require 'sinatra'
require 'sinatra/reloader'
require 'better_errors'
require 'erubis'

require 'open-uri'
require 'json'	
require 'uri'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path("..", __FILE__)
end


get '/' do
	erb :home
end

get '/search_results' do
	@title = params[:movie_title]
	file = open("http://www.omdbapi.com/?s=#{URI.escape(@title)}")
	@results = JSON.load(file.read)
	erb :search_results
end

get '/movies/:id' do
	@id = params[:id]
	file = open("http://www.omdbapi.com/?i=#{URI.escape(@id)}")
	@results = JSON.load(file.read)
	# @results.inspect
	erb :movie_info
end