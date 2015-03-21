require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require_relative 'lib/StoryHandler.rb'

require 'securerandom'

unless CLOUDANT_URL = ENV['CLOUDANT_URL']
  raise "You must specify the CLOUDANT_URL env variable"
end

DEFAULT_ERROR = '{"error"=>"not_found", "reason"=>"missing"}'

class Api < Hobbit::Base
  use Rack::Session::Cookie, secret: SecureRandom.hex(64)
  use Rack::ShowExceptions
  use Rack::Protection

  get '/' do
    'Hello world!'
  end

  get '/stories' do
    response['Content-Type'] = "application/json; charset=utf-8"
    get_stories
  end

  get '/stories/:id/:key' do
    response['Content-Type'] = "application/json; charset=utf-8"
    params = request.params
    get_story params[:id], params[:key]
  end

  get '/stories/:id' do
    response['Content-Type'] = "application/json; charset=utf-8"
    get_story request.params[:id]
  end

  get '/statistics' do
    response['Content-Type'] = "application/json; charset=utf-8"
    response['body'] = DEFAULT_ERROR
  end

  get '/statistics/:user' do
    response['Content-Type'] = "application/json; charset=utf-8"
    DEFAULT_ERROR
  end 
end
