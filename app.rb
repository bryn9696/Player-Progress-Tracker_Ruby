# frozen_string_literal: true

require "sinatra/activerecord"
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/reloader'
require './database_connection_setup'
# require './lib/bookings'
# require_relative './lib/makersbnb'
require './lib/user'
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
    erb :login
  end

  get '/sign_up' do
    erb :sign_up
  end

  post '/sign_up_details' do
    if User.unique_username(params[:username]) == true
      flash[:notice] = 'Thanks for signing up to Player progress Tracker'
      User.create_user(params[:username], params[:password], params[:email], params[:phone_number])
      redirect '/login'
    else
      flash[:notice] = 'This username has been taken - please choose a different one!'
      redirect '/sign_up'
    end
  end

  get '/login' do
    erb :login
  end

  post '/user_details' do
    session[:username] = params[:username]
    session[:password] = params[:password]
    redirect '/home'
  end

  get '/home' do
    if User.valid(session[:username], session[:password])
      session[:user_id] = User.user_id(username: session[:username])
      @username = session[:username]
      erb :home
    else
      flash[:notice] = 'Invalid username or password'
      redirect '/login'
    end
    
  end
end