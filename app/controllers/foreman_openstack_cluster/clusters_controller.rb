module ForemanOpenstackCluster
  class ClustersController < ::ApplicationController

    def new
      @controller_class = Puppetclass.find_by_name('quickstack::controller')
      @compute_class    = Puppetclass.find_by_name('quickstack::compute')
      not_found and return unless ( @controller_class && @compute_class )
      @cluster = Cluster.new
    end

    def create
      @cluster = Cluster.new(params['foreman_openstack_cluster_cluster'])
      if @cluster.save
        Rails.logger.info "More code here please"
        process_success({:success_redirect => hostgroups_path})
      else
        process_error :render => 'foreman_openstack_cluster/clusters/new', :object => @cluster
      end
    end


  end
end
