class SiteController < ApplicationController

  def index
    @games = Game.all
    flash[:alert] = ENV["LANDING_NOTICE"] unless flash[:alert]
  end

end
