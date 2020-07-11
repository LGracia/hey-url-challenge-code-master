# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  subject { build(:url) }
  let(:url) { create(:url) }

  describe 'validations' do
    it 'returns true when all validations pass' do
      subject.generate_short_url!

      expect(subject.valid?).to be_truthy
    end

    it 'returns false when a short_url is not generated' do
      expect(subject.valid?).to be_falsey
    end

    it 'returns false when the original_url has an invalid format' do
      subject.original_url = 'http://www.google .com'

      expect(subject.valid?).to be_falsey
    end

    it 'returns false when the short_url has more than 5 characters' do
      subject.short_url = '123456'

      expect(subject.valid?).to be_falsey
    end

    it 'returns false when the short_url is not present' do
      expect(subject.valid?).to be_falsey
    end

    it 'returns false when the original_url is not present' do
      subject.original_url = nil

      expect(subject.valid?).to be_falsey
    end

    it 'returns false when the original_url is already created' do
      subject.original_url = url.original_url

      expect(subject.valid?).to be_falsey
    end

    it 'returns false when the short_url is already created' do
      subject.short_url = url.short_url

      expect(subject.valid?).to be_falsey
    end
  end
end
