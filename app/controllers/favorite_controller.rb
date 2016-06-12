class FavoriteController < ApplicationController
  def create
    Favorite.create(number: params[:number])
    head :ok
  end

  def destroy
    if (fav = Favorite.find_by(number: params[:number])).nil?
      head 404
    else
      fav.destroy
      head :ok
    end
  end
end
