module ForemanOpenstackCluster
  class Cluster < ActiveRecord::Base
    include HostCommon

    #### Make a table-less model to avoid pointless migrations
    def self.columns
      @columns ||= [];
    end

    def self.column(name, sql_type = nil, default = nil, null = true)
      columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default,
                                                              sql_type.to_s, null)
    end

    # Override the save method to prevent exceptions.
    def save(validate = true)
      validate ? valid? : true
    end
    #### end Tableless

    column :architecture_id, :integer
    column :domain_id, :integer
    column :environment_id, :integer
    column :medium_id, :integer
    column :operatingsystem_id, :integer
    column :ptable_id, :integer
    column :puppet_ca_proxy_id, :integer
    column :puppet_proxy_id, :integer
    column :subnet_id, :integer
    validates_presence_of :architecture_id
    validates_presence_of :domain_id
    validates_presence_of :environment_id
    validates_presence_of :medium_id
    validates_presence_of :operatingsystem_id
    validates_presence_of :ptable_id
    validates_presence_of :puppet_ca_proxy_id
    validates_presence_of :puppet_proxy_id
    validates_presence_of :subnet_id

    def name
      "Openstack Cluster"
    end

  end
end
