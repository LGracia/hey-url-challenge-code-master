# frozen_string_literal: true

FactoryBot.define do
  factory :click do
    browser { ['Chrome', 'Safari', 'Firefox', 'Opera'].sample }
    platform { ['Windows', 'Ubuntu', 'MacOs', 'Android', 'iOs'].sample }
  end
end
