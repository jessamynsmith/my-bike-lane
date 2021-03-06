MyBikeLane::Application.routes.draw do
  resources :subscriptions


  resources :organizations

  resources :violators do
    collection do
      get 'autocomplete'
    end
  end

  match '/robots.txt' => 'pages#robots'
  resources :pages
  match '/page/:id', to: 'pages#public_show', as: 'public_page'

  resources :blog_posts
  match '/blog', to: 'blog_posts#public_index', as: 'public_blog_posts'
  match '/blog/:id', to: 'blog_posts#show', as: 'public_blog_post'


  resources :photos

  devise_for :users, :path_prefix => 'my', controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  resources :users, :only => [:index, :show]


  match 'sort/:type', to: 'violations#index', as: 'sorted_violations'
  resources :violations do
    member do
      get 'up_vote'
      get 'down_vote'
      get 'un_vote'
      get 'flag'
      get 'unflag'
      get 'spam'
      get 'ham'
    end
    collection do
      get 'page/:page', :action => :index
      get 'heatmap'
      get 'flagged'
      get 'spammed'
    end
  end


  resources :announcements
  match 'announcements/:id/hide', to: 'announcements#hide', as: 'hide_announcement'

  match 'feedback', to: 'application#feedback'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'violations#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
