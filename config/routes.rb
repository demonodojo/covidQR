Rails.application.routes.draw do
  resources :certifications
  root :to => redirect('/certifications')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
