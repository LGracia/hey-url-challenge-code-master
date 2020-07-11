# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Click, type: :model do
  subject { build(:click) }
  let(:url) { create(:url) }

  describe 'validations' do
    it 'validates url_id is valid' do
      subject.url = url
      expect(subject.valid?).to be_truthy
    end

    it 'returns false when browser is null' do
      subject.browser = nil
      expect(subject.valid?).to be_falsey
    end

    it 'returns false when platform is null' do
      subject.platform = nil
      expect(subject.valid?).to be_falsey
    end
  end
end
