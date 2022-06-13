# frozen_string_literal: true

require "sinatra/activerecord"
require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/reloader'
require './database_connection_setup'
# require './lib/bookings'
require_relative './lib/teams'
require './lib/user'
require_relative './lib/update'
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
      @teams = MyTeams.view_teams
      @username = session[:username]
      @user_id = session[:user_id]
      erb :home
    else
      flash[:notice] = 'Invalid username or password'
      redirect '/login'
    end 
  end

  get '/form_a_team' do
    erb :'form_a_team'
  end

  post '/team_created' do
    p '**************************************'
    @teamname = params[:team_name]
    @user = session[:user_id]
    @number_of_players = params[:number_of_players]
    p @teamname
    p @user
    p @number_of_players
    p "coach/manager - #{params[:coach_or_manager]}"
    p "teamurl - #{params[:team_url]}"
    if MyTeams.exist?(team_name: params[:team_name])
      @team_name = params[:team_name]
      @number_of_players = params[:number_of_players]
      @coach_or_manager = params[:coach_or_manager]
        redirect '/form_a_team'
    else
      MyTeams.create_team(team_name: params[:team_name], number_of_players: params[:Number_of_Players], coach_or_manager: params[:Coach_or_Manager], user_id: params[:user_id])
      @team_name = MyTeams.create_team(team_name: params[:team_name], number_of_players: params[:Number_of_Players], coach_or_manager: params[:Coach_or_Manager], user_id: params[:user_id])
      @number_of_players = params[:number_of_players]
      @coach_or_manager = params[:coach_or_manager]
      p '**********************************'
      p @team_name
      p @number_of_players
      erb :'team_created_success'
    end
  end

  get '/edit_a_team' do
    p '**********************************'
    p @number_of_players
    p @user
    erb :edit_a_team
  end

  get '/my_teams' do
    if User.valid(session[:username], session[:password])
      session[:user_id] = User.user_id(username: session[:username])
      @teams = MyTeams.view_teams
      @username = session[:username]
      @user_id = session[:user_id]
    erb :my_teams
    end
  end
end