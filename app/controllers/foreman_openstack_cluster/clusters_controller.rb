module ForemanOpenstackCluster
  class ClustersController < ::ApplicationController

    def new
      @controller_class = Puppetclass.find_by_name('quickstack::controller')
      @compute_class    = Puppetclass.find_by_name('quickstack::compute')
      not_found and return unless ( @controller_class && @compute_class )
      @cluster = Cluster.new
    end

  end
end
