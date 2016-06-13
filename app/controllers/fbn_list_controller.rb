class FbnListController < ApplicationController
  DEFAULT_PARAMS = {
    offset: 1,
    limit: 100
  }

  private def sanitize_integer(data, default)
    data.nil? ? default : Integer(data)
  rescue ArgumentError
    default
  end

  private def sanitize_params
    [:offset, :limit].each do |pm|
      params[pm] = sanitize_integer(params[pm], DEFAULT_PARAMS[pm])
    end
  end

  # rather than just exposing @numbers and favorites they are
  # bound together in a single array of pairs to make it easier
  # to handle in the view
  private def number_list_with_favs(numbers, favorites)
    favorites = favorites.map(&:to_i)
    numbers.map { |n| [n, favorites.include?(n.to_i)] }
  end

  # this converts the sub-arrays from the regular number list
  # to hashes so that they come up as objects in JSON with
  # named properties
  private def json_number_list_with_favs(numbers, favorites)
    number_list_with_favs(numbers, favorites).map do |nb, is_fav|
      Hash[[:number, :favorite].zip([nb.to_s, is_fav])]
    end
  end

  def show
    sanitize_params
    @offset = params[:offset]
    @limit = params[:limit]
    last = @offset + @limit

    @numbers = FizzBuzzNumber.range(@offset...last)
    favorites = Favorite.where(number: @offset...last)
    @fav = favorites
    @prev_page_link = url_for(offset: @offset - @limit, limit: @limit)
    @next_page_link = url_for(offset: @offset + @limit, limit: @limit)

    respond_to do |format|
      format.html { @numbers = number_list_with_favs(@numbers, favorites)}
      format.json do
        @numbers = json_number_list_with_favs(@numbers, favorites)
        render json: @numbers
      end
    end
  end
end
