# -*- coding: utf-8 -*-
require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

require_relative 'lib/EnvKeys.rb'
require_relative 'lib/StoryHandler.rb'
require_relative 'lib/Errors.rb'

require 'securerandom'

class Api < Roda
  use Rack::Session::Cookie, secret: SecureRandom.hex(64)
  use Rack::ShowExceptions
  use Rack::Protection

  plugin :render, :engine => 'haml', :template_opts => { :default_encoding => 'UTF-8' }
  plugin :static, [ '/images']

  route do | r |

    # GET /
    r.root do
      render("index")
    end

    # /stories branch
    r.on 'stories' do
      response['Content-Type'] = "application/json; charset=utf-8"

      r.get ':id/:key' do | id, key |
        http = Keen.publish_async("story_key", { :source => r.params["source"], :story_id => id, :key => key})
        get_key_from_story(id, key).to_json
      end

      r.get ':id' do | id |
        http = Keen.publish_async("story", { :source => r.params["source"], :story_id => id, :update => r.params["update"] })
        get_story(id).to_json
      end

      # GET /stories
      r.get do
        http = Keen.publish_async("list_stories", { :source => r.params["source"] })
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
