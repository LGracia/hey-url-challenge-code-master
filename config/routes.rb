# frozen_string_literal: true

Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
  root to: 'urls#index'

  resources :urls, only: %i[index create show], param: :url
  get ':url', to: 'urls#visit', as: :visit
end
