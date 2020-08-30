Rails.application.routes.draw do
  resources :artists
  resources :record_labels
  resources :master_releases
  resources :releases
  resources :tracks
  resources :formats
  resources :images
end
