# frozen_string_literal: true

class Click < ApplicationRecord
  belongs_to :url

  scope :daily_clicks, ->(url_id) { where(url_id: url_id).group_by_day(:created_at, format: "%d") }
  scope :browsers_clicks, ->(url_id) { where(url_id: url_id).group(:browser) }
  scope :platform_clicks, ->(url_id) { where(url_id: url_id).group(:platform) }

  validates_presence_of :platform, :browser
end
