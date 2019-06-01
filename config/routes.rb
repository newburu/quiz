Rails.application.routes.draw do
  resources :answers
  resources :questions
  
  # API用(JSONを返すため、formatを指定する)
  namespace :api, { format: 'json' } do
    namespace :v1 do # APIのため、バージョンを意識して作る
      get 'questions/:id', to: 'questions#show'
    end
  end
end
