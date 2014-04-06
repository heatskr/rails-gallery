Gallery::Application.routes.draw do
  resources :albums do
    resources :pictures, except: [:new, :edit]
  end
  root 'albums#index'
end
