require 'deface'
require 'foreman_openstack_cluster'

module ForemanOpenstackCluster
  #Inherit from the Rails module of the parent app (Foreman), not the plugin.
  #Thus, inherits from ::Rails::Engine and not from Rails::Engine
  class Engine < ::Rails::Engine

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/helpers/concerns"]
    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]

    def use_relative_model_naming
      true
    end

    rake_tasks do
      load "foreman_openstack_cluster.rake"
    end

  end
end
