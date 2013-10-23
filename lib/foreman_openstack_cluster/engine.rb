require 'deface'
require 'foreman_openstack_cluster'

module ForemanOpenstackCluster
  #Inherit from the Rails module of the parent app (Foreman), not the plugin.
  #Thus, inherits from ::Rails::Engine and not from Rails::Engine
  class Engine < ::Rails::Engine

    rake_tasks do
      load "foreman_openstack_cluster.rake"
    end

  end
end
