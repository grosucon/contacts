# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

# resources :contacts

resources :projects do
  resources :contacts
end

