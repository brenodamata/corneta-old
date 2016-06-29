Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }
  # devise_for :users, class_name: "FromUser"
  resources :teams
  root to: 'pages#main'
end
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
