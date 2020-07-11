# frozen_string_literal: true

class UrlsController < ApplicationController
  before_action :find_url, only: [:show, :visit]

  def index
    @url = Url.new
    @urls = Url.latest.limit(10)
  end

  def create
    @url = Url.new(url_params)
    @url.generate_short_url!
    if @url.save
      redirect_to action: 'index'
      return
    end

    error
  end

  def show
    @daily_clicks = Click.daily_clicks(@url.id).count.to_a
    @browsers_clicks = Click.browsers_clicks(@url.id).count.to_a
    @platform_clicks = Click.platform_clicks(@url.id).count.to_a
  end

  def visit
    @click = Click.new(url: @url, browser: browser.name, platform: browser.platform.id)
    if @click.save
      clicks = @url.clicks_count + 1
      @url.update(clicks_count: clicks)

      redirect_to action: 'index'
      return
    end

    error
  end

  private

  def url_params
    params.require(:url).permit(:original_url)
  end

  def find_url
    @url = Url.find_by(short_url: params[:url]) or not_found
  end
end
