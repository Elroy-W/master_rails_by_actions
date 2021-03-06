# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user)
    .permit(:email, :password, :password_confirmation))
    @user.uuid = session[:user_uuid]

    if @user.save
      flash[:notice] = 'Sign  Successfully, please log in'
      redirect_to new_session_path
    else
      render action: :new
    end
  end
  end
