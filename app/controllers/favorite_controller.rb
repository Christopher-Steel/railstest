class FavoriteController < ApplicationController
  def create
    Favorite.create(number: params[:number])
    head :ok
  end

  def destroy
    unless (fav = Favorite.find_by(number: params[:number])).nil?
      fav.destroy
    end
    head :ok
  end
end
