Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: 'menu#main'
  get "/teams", to: 'teams#index'
  get "/teams/new", to: 'teams#new'
  post "/teams", to: 'teams#create'
  get "/teams/:id", to: 'teams#show'
  get "/players", to: 'players#index'
  get "players/eligible", to: 'players#eligible'
  get "/players/:id", to: 'players#show'
  get "/teams/:id/players", to: 'team_players#index'
  get "/teams/:id/edit", to: 'teams#edit'
  get "/teams/:id/sort", to: 'team_players#name_sort'
  patch "/teams/:id", to: 'teams#update'
  get "/teams/:id/players/new", to: 'team_players#new'
  post "/teams/:id/players", to: 'team_players#create_player'
  get "/players/:id/edit", to: 'players#edit'
  patch "/players/:id", to: 'players#update'
  
end
