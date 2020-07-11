# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def not_found
    render :file => "#{Rails.root}/public/404.html", status: 404
  end

  def error
    render :file => "#{Rails.root}/public/500.html", status: 500
  end
end
