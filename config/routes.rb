Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks',
                                    registrations: 'registrations' }

  resources :users do
    get 'new_account', on: :member
    get :show, on: :member
  end

  resources :teams
  root to: 'pages#main'
end
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
