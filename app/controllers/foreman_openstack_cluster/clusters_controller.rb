module ForemanOpenstackCluster
  class ClustersController < ::ApplicationController
    unloadable

    def new
      @hostgroup = Hostgroup.new
    end

  end
end
