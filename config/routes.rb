Rails.application.routes.draw do
    #sessions!
    root 'sessions#index'

    get '/sessions/new' => 'sessions#index'
    post '/sessions/login' => 'sessions#login'
    delete '/sessions' => 'sessions#logout'

    #users!
    get '/users/new' => 'users#register'
    post '/users/create' => 'users#create'

    #users with variable parameters!
    get '/users/:id' => 'users#show'
    get '/users/:id/edit' => 'users#edit'
    post '/users/:id/edit' => 'users#update'
    delete '/users/:id' => 'users#destroy'

    #secrets!
    get '/secrets' => 'secrets#index'
    post '/secrets/add' => 'secrets#create'

    #secrets with variable parameters!
    delete '/secrets/likes/:id' => 'secrets#unlike'
    post '/secrets/:id' => 'secrets#like'
    delete '/secrets/:id' => 'secrets#destroy'
end
