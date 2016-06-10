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

  def show
    sanitize_params
    @offset = params[:offset]
    @limit = params[:limit]
    last = @offset + @limit

    @numbers = FizzBuzzNumber.range(@offset...last).map(&:to_s)
    favourites = Favourite.where(number: @offset...last)
    @prev_page_link = url_for(offset: @offset - @limit, limit: @limit)
    @next_page_link = url_for(offset: @offset + @limit, limit: @limit)

    respond_to do |format|
      format.html
      format.json { render json: @numbers }
    end

  end
end
