# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UrlsController, type: :controller do
  let(:url_attributes) { build(:url).attributes }
  let(:url) { create(:url) }
  let(:click) { create(:click, url: url) }

  describe 'GET #index' do
    before do
      url
      10.times do
        create(:url)
      end
    end

    it 'shows the latest 10 URLs' do
      get :index
      expect(assigns(:urls)).not_to include(url)
    end
  end

  describe 'POST #create' do
    it 'creates a new url' do
      post :create, params: { url: url_attributes }
      expect(response).to redirect_to(action: :index)
    end

    it 'returns an error' do
      url_attributes['original_url'] = 'http://www.google .com'
      post :create, params: { url: url_attributes }
      expect(response).to have_http_status(:internal_server_error)
    end
  end

  describe 'GET #show' do
    it 'shows stats about the given URL' do
      get :show, params: { url: click.url.short_url }

      expect(assigns(:daily_clicks).size).to eq(1)
      expect(assigns(:browsers_clicks).size).to eq(1)
      expect(assigns(:platform_clicks).size).to eq(1)
    end

    it 'throws 404 when the URL is not found' do
      get :show, params: { url: '123456' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET #visit' do
    it 'tracks click event and stores platform and browser information' do
      get :visit, params: { url: url.short_url }

      expect(assigns(:url).clicks_count).to eq(1)
      expect(Click.count).to eq(1)
    end

    it 'redirects to the original url' do
      get :visit, params: { url: url.short_url }
      expect(response).to redirect_to(action: :index)
    end

    it 'throws 404 when the URL is not found' do
      get :visit, params: { url: '123456' }
      expect(response).to have_http_status(:not_found)
    end
  end
end
