# frozen_string_literal: true

class Url < ApplicationRecord
  # scope :latest, -> {}

  scope :latest, -> { order(created_at: :desc) }

  validates :short_url, presence: true, uniqueness: true, length: { maximum: 5 }
  validates :original_url, presence: true, uniqueness: true
  validate :original_url_format

  def generate_short_url!
    self.short_url = Digest::MD5.hexdigest(self.original_url)[0..4]
  end

  private

  def original_url_format
    uri = URI.parse(original_url)
    uri.is_a?(URI::HTTP) && !uri.host.nil?
  rescue URI::InvalidURIError
    errors.add(:original_url, 'has an invalid format.')
  end
end
