class UsersController < ApplicationController

  def show
    @user = User.find_by(id: params[:id])
    @reviews = @user.ratings.paginate(page: params[:page])
  end

  def ban
    if current_user.admin?
      @user = User.find_by(id: params[:id])
      @user.banned = true
      @user.ratings.delete_all
      @user.save
    end

    redirect_to root_path
  end

end

