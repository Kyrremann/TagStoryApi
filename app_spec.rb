require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'
require './app.rb'

describe Api do
  include Rack::Test::Methods

  def Api
    Api.new
  end

  describe 'GET /' do
    it 'must be ok' do
      get '/'
      last_response.must_be :ok?
      last_response.body.must_match /Hello world!/
    end
  end
end
