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
      @reviews = @game.ratings.paginate(:page => params[:page], per_page: 6)
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
    @game = Game.new(permitted_params)
    @game.user = current_user
    @game.save

    if @game.errors.size > 0
      flash[:error] = @game.errors.full_messages[0]
    end

    redirect_to show_game_path(steam_appid: params[:game][:steam_appid])
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
      @game = Game.find_by(steam_appid: params[:steam_appid])
    end

    def permitted_params
      params.require(:game).permit(:steam_appid)
    end

end

