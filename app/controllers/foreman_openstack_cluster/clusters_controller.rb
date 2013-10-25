module ForemanOpenstackCluster
  class ClustersController < ::ApplicationController

    def new
      @controller_class = Puppetclass.find_by_name('quickstack::controller')
      @compute_class    = Puppetclass.find_by_name('quickstack::compute')
      not_found and return unless ( @controller_class && @compute_class )

      # Setup the override keys on the classes ahead of time
      set_keys(@controller_class)
      set_keys(@compute_class)

      @cluster = Cluster.new
      Cluster.params.each do |k,v|
        @cluster.send("#{k}=",v[:default])
      end
    end

    def create
      @cluster = Cluster.new(params['foreman_openstack_cluster_cluster'])
      if @cluster.save
        setup_quickstack "quickstack::controller"
        setup_quickstack "quickstack::compute" 
        process_success({:success_redirect => hostgroups_path})
      else
        process_error :render => 'foreman_openstack_cluster/clusters/new', :object => @cluster
      end
    end

    private

    def setup_quickstack type
      @qs_class = Puppetclass.find_by_name(type)
      @parent   = Hostgroup.first #replace this with Dom's provisioning group

      # Borrowed from Hostgroup#nest
      @hostgroup                = Hostgroup.find_or_create_by_name(type.split('::').map{|a| a.capitalize}.join(' '))
      @hostgroup.environment_id = @parent.environment_id
      @hostgroup.parent_id      = @parent.id
      @hostgroup.locations      = @parent.locations
      @hostgroup.organizations  = @parent.organizations
      # Clone any parameters as well
      @hostgroup.group_parameters.each{|param| @parent.group_parameters << param.dup}

      # Add quickstack stuff
      @hostgroup.puppetclasses = [@qs_class]
      params[:foreman_openstack_cluster_cluster].each do |k,v|
        lk = Puppetclass.find_by_name(type).class_params.override.find_by_key(k)
        next if lk.nil?
        lv = LookupValue.find_or_initialize_by_match_and_lookup_key_id("hostgroup=#{@hostgroup.label}", lk.id)
        lv.value = v
        lv.save!
      end
      @hostgroup.save!
      true
    end

    def set_keys pclass
      Cluster.params.each do |k,v|
        if cp = pclass.class_params.find_by_key(k)
          cp.override = true
          if cp.key_type != v[:type].to_s
            # If we alter the key_type we may also break the default so update both
            cp.key_type = v[:type].to_s
            cp.default_value = v[:default].to_s
          end
          cp.save!
        end
      end
    end

  end
end
