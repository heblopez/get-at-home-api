Rails.application.routes.draw do
    get "/health" => "health#health"

    post "/login" => "sessions#create"
    get "/logout" => "sessions#destroy"

    resources :users, only: %i[create show update] do
        resources :favorites, only: %i[index update]
        post '/favorites/:id', to: 'favorites#create'
        resources :contacted, only: %i[index update]
        post '/contacted/:id', to: 'contacted#create'
    end

    resources :properties, only: %i[create show update index destroy]
end
