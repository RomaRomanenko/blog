class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction

  skip_before_filter :require_login, only: [:index, :new, :create]
  
  def index
    @users = User.order(sort_column + " " + sort_direction)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_path, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    render :edit unless @user.update_attributes(params[:user])
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path   
  end

  private

  def sort_column
    params[:sort] || "first_name"
  end

  def sort_direction
    params[:direction] || "asc"
  end
end