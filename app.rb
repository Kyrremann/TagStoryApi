# -*- coding: utf-8 -*-
require 'rubygems'
require 'tilt/haml'
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
  plugin :multi_route
  Dir['./routes/*.rb'].each{ | file | require file }

  route do | r |

    # GET /
    r.root do
      render("index")
    end

    r.multi_route
  end
end
