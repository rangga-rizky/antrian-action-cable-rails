Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "/tickets" , to: "tickets#create"
  put "/tickets/:id" , to: "tickets#action"
  get "/tickets" , to: "tickets#index"
  get "/tickets/client" , to: "tickets#displayOnClient"
  get "/tickets/public" , to: "tickets#displayOnPublic"
end
