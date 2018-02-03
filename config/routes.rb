Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#callback'
  get '/logout', to: 'sessions#destroy'

  resource :user_form, only: %i[new create]
  get '/result', to: 'homes#result', as: 'result'

  root 'homes#index'
end
