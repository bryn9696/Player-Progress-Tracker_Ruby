# frozen_string_literal: true

require "sinatra/activerecord"
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/reloader'
require './database_connection_setup'
# require './lib/bookings'
# require_relative './lib/makersbnb'
# require './lib/user'
# require_relative './lib/update'
# require './lib/images'


# App class
class PlayerProgressTracker < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions
  register Sinatra::Flash

  get '/' do
    erb :index
  end

end