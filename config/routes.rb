Rails.application.routes.draw do
  root "movies#index"

  resources :movies
  get "/search/:term", to: "movies#search"
end
