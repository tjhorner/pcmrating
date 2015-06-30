class RatingsController < ApplicationController

  before_action :user?, except: [:show]
  before_action :admin?, only: [:destroy]

  def show
    @game = Game.find_by(slug: params[:game_id])
    @rating = Rating.find_by(id: params[:id], game: @game)
  end

  def edit
    @game = Game.find_by(slug: params[:game_id])
    @rating = Rating.find_by(user: current_user, game: @game)

    redirect_to game_path(id: @game.slug) unless @rating
  end

  def new
    @game = Game.find_by(slug: params[:game_id])
    @rating = @game.ratings.new
  end

  def create
    @game = Game.find_by(slug: params[:game_id])
    @rating = Rating.new(permitted_params)
    @rating.user = current_user
    @rating.game = @game

    if @rating.save
      redirect_to game_path(id: @game.slug)
    else
      render :new
    end
  end

  def update
    @game = Game.find_by(slug: params[:game_id])
    @rating = Rating.find_by(user: current_user, game: @game)
    @rating.update_attributes(permitted_params)

    redirect_to game_rating_path(game_id: @rating.game, id: @rating.id)
  end

  def destroy
    @rating = Rating.find_by(id: params[:id])

    @rating.destroy

    redirect_to show_game_path(steam_appid: @rating.game.steam_appid)
  end

  private

  def user?
    flash[:success] = 'Login or signup to continue'
    redirect_to new_user_session_path unless current_user
  end

  def admin?
    redirect_to root_path unless current_user.admin?
  end

  def owned_by_user?
    redirect_to root_path unless @rating.user == current_user
  end

  def permitted_params
    params.require(:rating).permit(
      :framerate, :resolution, :optimization, :mods,
      :servers, :dlc, :bugs, :settings, :controls, :review)
  end

end
