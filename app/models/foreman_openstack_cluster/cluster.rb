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

    # Basic Validations

    column :name, :string
    validates_presence_of :name

    column :hostgroup_id, :integer
    belongs_to :hostgroup

    column :environment_id, :integer
    belongs_to :environment

    attr_accessor :public_subnet, :private_subnet

    # Class parameters to be supplied

    def self.params
      @params ||= {};
    end

    def self.param args
      name = args[:name] || return
      default = args[:default] || ''
      type = args[:type] || :string
      advanced = args[:advanced].present? ? true : false

      params.merge! name => { :default     => default,
                              :type        => type,
                              :placeholder => args[:placeholder],
                              :description => args[:description],
                              :advanced    => advanced }

      column name.to_sym, type
      validates_presence_of name.to_sym unless type == :boolean
    end

    param :name => 'verbose', :default => true, :type => :boolean

    param :name => 'private_interface',          :placeholder => 'eth0',
          :description => 'The private interface of the Foreman host'
    param :name => 'public_interface',           :placeholder => 'eth1',
          :description => 'The public interface of the Foreman host'
    param :name => 'fixed_network_range',        :placeholder => '10.1.1.0/24',
          :description => 'The fixed network range internal to OpenStack'
    param :name => 'floating_network_range',     :placeholder => '192.168.1.1/24',
          :description => 'The floating network range OpenStack will use to assign IPs'
    param :name => 'pacemaker_priv_floating_ip', :placeholder => '10.1.1.2',
          :description => 'The IP on the private network to be used as a virtual IP'
    param :name => 'pacemaker_pub_floating_ip',  :placeholder => '192.168.1.2',
          :description => 'The IP on the public network to be used as a virtual IP'
    param :name => 'admin_email',                :default => "admin@#{Facter.domain}",
          :description => 'Contact email for the cluster'

    param :name => 'admin_password',       :default => SecureRandom.hex, :advanced => true
    param :name => 'cinder_db_password',   :default => SecureRandom.hex, :advanced => true
    param :name => 'cinder_user_password', :default => SecureRandom.hex, :advanced => true
    param :name => 'glance_db_password',   :default => SecureRandom.hex, :advanced => true
    param :name => 'glance_user_password', :default => SecureRandom.hex, :advanced => true
    param :name => 'horizon_secret_key',   :default => SecureRandom.hex, :advanced => true
    param :name => 'keystone_admin_token', :default => SecureRandom.hex, :advanced => true
    param :name => 'keystone_db_password', :default => SecureRandom.hex, :advanced => true
    param :name => 'mysql_root_password',  :default => SecureRandom.hex, :advanced => true
    param :name => 'nova_db_password',     :default => SecureRandom.hex, :advanced => true
    param :name => 'nova_user_password',   :default => SecureRandom.hex, :advanced => true

    # Helpers for the two types of params

    def self.basic_params
      params.reject {|p,d| d[:advanced].present? }
    end

    def self.advanced_params
      params.reject {|p,d| d[:advanced].blank? }
    end

  end
end
