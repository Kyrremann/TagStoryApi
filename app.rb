# -*- coding: utf-8 -*-
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require_relative 'lib/StoryHandler.rb'
require_relative 'lib/Errors.rb'

require 'securerandom'

unless CLOUDANT_URL = ENV['CLOUDANT_URL']
  raise "You must specify the CLOUDANT_URL env variable"
end

class Api < Roda
  use Rack::Session::Cookie, secret: SecureRandom.hex(64)
  use Rack::ShowExceptions
  use Rack::Protection

  route do | r |

    # GET /
    r.root do
      'Hello world!'
    end

    # /stories branch
    r.on 'stories' do
      response['Content-Type'] = "application/json; charset=utf-8"

      r.get ':id/:key' do | id, key |
        get_key_from_story(id, key).to_json
      end

      r.get ':id' do | id |
        get_story(id).to_json
      end

      # GET /stories
      r.get do
        get_stories.to_json
      end
    end

    r.on "statistics" do
      response['Content-Type'] = "application/json; charset=utf-8"

      r.get ':user' do | user |
      end

      r.get do
      end
    end
  end
end
