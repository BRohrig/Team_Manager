Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: 'menu#main'

  get "/teams", to: 'teams#index'
  get "/teams/new", to: 'teams#new'
  post "/teams", to: 'teams#create'
  delete "/teams", to: 'teams#destroy'

  get "/teams/:id", to: 'teams#show'
  get "/teams/:id/players", to: 'team_players#index'

  get "/players", to: 'players#index'
  delete "players", to: 'players#destroy'
  get "/players/:id", to: 'players#show'

  get "/teams/:id/edit", to: 'teams#edit'
  patch "/teams/:id", to: 'teams#update'

  patch "/players/:id/edit", to: 'players#edit'
  patch "/players/:id", to: 'players#update'
  get "/players/:id/delete", to: 'players#destroy'

  get "/teams/:id/delete", to: 'teams#destroy'
  get "/teams/:id/players/new", to: 'team_players#new'
  post "/teams/:id/players", to: 'team_players#create_player'
end
