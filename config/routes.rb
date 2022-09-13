Rails.application.routes.draw do
  root to: 'furima-25061#index'
  resources :furima-25061, only:[:index]
end
