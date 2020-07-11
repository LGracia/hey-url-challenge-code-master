# frozen_string_literal: true

FactoryBot.define do
  factory :url do
    original_url { Faker::Internet.url }
    
    before(:create) do |url|
      url.generate_short_url!
    end
  end
end
