C2::Application.routes.draw do
  post 'send_cart' => 'communicarts#send_cart'
  post 'approval_reply_received' => 'communicarts#approval_reply_received'
  match 'approval_response', to: 'communicarts#approval_response', via: [:get, :put]
  root :to => 'home#index'
  match "/auth/:provider/callback" => "home#oauth_callback", via: [:get]
  post "/logout" => "home#logout"

  resources :carts do
    resources :comments
  end

  resources :cart_items do
    resources :comments
  end

  get 'bookmarklet', to: redirect('bookmarklet.html')
  get "/498", :to => "errors#token_authentication_error"

end
