Rails.application.routes.draw do
  # We call the resources method and pass it a Symbol. This instructs Rails to create post routes
  # for creating, updating, viewing, and deleting instances of Post. We'll review the precise URIs created in a moment.
  
  resources :topics do
    # We pass resources :posts to the resources :topics block. This nests the post routes under the topic routes.
    resources :posts, except: [:index]
  end
  
  # We use only: [] because we don't want to create any /posts/:id routes, just  posts/:post_id/comments routes.
  resources :posts, only: [] do
    # We only add create and destroy routes for comments. We'll display comments on the posts show view, so we won't need
    # index or new routes. We also won't give users the ability to view individual comments or edit comments, removing the
    # need for show, update, and edit routes.
    resources :comments, only: [:create, :destroy]
    
    # These new lines create POST routes at the URL posts/:id/up-vote and  posts/:id/down-vote. 
    # The as key-value pairs at the end stipulate the method names which will be associated with 
    # these routes: up_vote_path and down_vote_path.
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end
  
  # We create routes for new and create actions. The only hash key will prevent Rails from creating unnecessary routes.
  resources :users, only: [:new, :create]
  
  resources :sessions, only: [:new, :create, :destroy]
   
  # We remove get "welcome/index" because we've declared the index view as the root view. We also modify
  # the about route to allow users to visit /about, rather than  /welcome/about.

  get 'about' => 'welcome#about'
  
  root 'welcome#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
