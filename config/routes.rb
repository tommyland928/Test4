Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'chips#index'
  get 'chips' => 'chips#index'
  get 'chips/rank' => 'chips#rank'
  get 'chips/add' => 'chips#add'
  get 'chips/general' => 'chips#general'


  get 'api/general' => 'api#general'
  get 'api/rank' => 'api#rank'
  get 'api/save' => 'api#save'
  get 'api/delete' => 'api#delete'
  get 'api/sent' => 'api#sent'
  get 'api/reset' => 'api#reset'

  post 'chips/store' => 'chips#store'
  post 'chips/save' => 'chips#save'
  post 'members' => 'chips#createm'

end
