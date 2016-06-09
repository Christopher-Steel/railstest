class FbnListController < ApplicationController
  DEFAULT_PARAMS = {
    offset: 1,
    limit: 100
  }

  def sanitize_integer(data, default)
    data.nil? ? default : Integer(data)
  rescue ArgumentError
    default
  end

  def sanitize_params
    [:offset, :limit].each do |pm|
      params[pm] = sanitize_integer(params[pm], DEFAULT_PARAMS[pm])
    end
  end

  def show
    sanitize_params
    offset = params[:offset]
    limit = params[:limit]
    last = offset + limit

    @list = FizzBuzzNumber.range(offset...last).map(&:to_s)
    @prev_page_link = url_for(offset: offset - limit, limit: limit)
    @next_page_link = url_for(offset: offset + limit, limit: limit)

    respond_to do |format|
      format.html { render :show }
      format.json { render json: @list }
    end

  end
end
