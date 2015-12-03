require 'securerandom'

class UsersController < ApplicationController
   skip_before_action :verify_authenticity_token
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  def profile
    User.where(username: params[:username])
    render json: params[:username]
  end

  def signup
    user = User.create(name: params[:name], 
                       username: params[:username],
                       password: params[:password], 
                       email: params[:email], 
                       phone: params[:phone],
                       balance: 0)
    puts user
    render json: user
  end

  def login
    username = params[:username]
    password = params[:password]
    result = User.where(username: username, password: password)
    
    if result != []
      res = {
        "message" => "success"
      }
      session[:username] = username
      cookies[:username] = username

      render json: res
    else
      res = {
        "message" => "please login again"
      }
      render json: res
    end
  end

  def logout
    session[:username] = nil
  end
end
