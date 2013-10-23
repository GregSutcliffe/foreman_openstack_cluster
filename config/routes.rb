Rails.application.routes.draw do
  namespace :foreman_openstack_cluster do
    match '/clusters/new', :to => 'clusters#new', :via => 'get'
  end
end

