Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: 'menu#main'
  get "/teams", to: 'teams#index'
  get "/teams/:id", to: 'teams#show'
  get "/players", to: 'players#index'
  get "/players/:id", to: 'players#show'
  get "/teams/:id/players", to: 'team_players#index'
  
end
