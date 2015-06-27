class UsersController < ApplicationController

  def show
    @user = User.find_by(id: params[:id])
    @reviews = @user.ratings.paginate(page: params[:page])
  end

end

