Rails.application.routes.draw do
  namespace :foreman_openstack_cluster do
    resources :clusters
  end
end

