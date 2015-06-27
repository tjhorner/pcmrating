class SiteController < ApplicationController

  def index
    @games = Game.all
    flash[:notice] = ENV["LANDING_NOTICE"] unless flash[:notice]
  end

end
