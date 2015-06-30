class GamesController < ApplicationController

  before_action :user?, except: [:index, :show]
  before_action :admin?, only: [:destroy]
  before_action :setup_game, except: [:index, :new, :create]

  def index
    @q = Game.ransack(params[:q])
    @games = @q.result.paginate(page: params[:page], per_page: 6)
  end

  def show
    if @game
      @reviews = @game.ratings.paginate(page: params[:page], per_page: 6)
    else
      @game = Game.new(steam_appid: params[:steam_appid])
      render :new
    end
  end

  def edit
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(permitted_params.merge(user: current_user))
    @game.save
    @game.save
    flash[:error] = @game.errors.full_messages[0]
    redirect_to game_path(id: @game.slug)
  end

  def destroy
    @game.destroy
  end

  private

  def user?
    flash[:success] = 'Login or signup to continue'
    redirect_to new_user_session_path unless current_user
  end

  def admin?
    redirect_to root_path unless current_user.admin?
  end

  def setup_game
    @game = Game.friendly.find(params[:id])
  end

  def permitted_params
    params.require(:game).permit(:steam_appid)
  end

end
