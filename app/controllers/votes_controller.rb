class VotesController < ApplicationController

  before_action :user?, except: [:show]
  before_action :setup_rating

  def upvote
    @rating.liked_by current_user

    redirect_to show_game_path(steam_appid: @rating.game.steam_appid)
  end

  def downvote
    @rating.downvote_from current_user

    redirect_to show_game_path(steam_appid: @rating.game.steam_appid)
  end

  private

    def user?
      flash[:success] = 'Login or signup to continue'
      redirect_to new_user_session_path unless current_user
    end

    def setup_rating
      @rating = Rating.find_by(id: params[:id])
      redirect_to root_path unless @rating
    end

end
