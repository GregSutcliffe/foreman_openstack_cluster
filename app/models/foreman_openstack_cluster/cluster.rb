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

    def self.params
      @params ||= {};
    end

    def self.param(name, default, type = :string, advanced = nil)
      params.merge! name => { :default => default,
                              :type => type,
                              :advanced => advanced.present?
      }
    end

    param "verbose",                    "true",                  :boolean
    param "private_interface",          'PRIV_INTERFACE'
    param "public_interface",           'PUB_INTERFACE'
    param "fixed_network_range",        'PRIV_RANGE'
    param "floating_network_range",     'PUB_RANGE'
    param "pacemaker_priv_floating_ip", 'PRIV_IP'
    param "pacemaker_pub_floating_ip",  'PUB_IP'
    param "admin_email",                "admin@#{Facter.domain}"

    param "admin_password",       SecureRandom.hex, nil, true
    param "cinder_db_password",   SecureRandom.hex, nil, true
    param "cinder_user_password", SecureRandom.hex, nil, true
    param "glance_db_password",   SecureRandom.hex, nil, true
    param "glance_user_password", SecureRandom.hex, nil, true
    param "horizon_secret_key",   SecureRandom.hex, nil, true
    param "keystone_admin_token", SecureRandom.hex, nil, true
    param "keystone_db_password", SecureRandom.hex, nil, true
    param "mysql_root_password",  SecureRandom.hex, nil, true
    param "nova_db_password",     SecureRandom.hex, nil, true
    param "nova_user_password",   SecureRandom.hex, nil, true

    def self.basic_params
      Rails.logger.info params.inspect
      params.reject {|p,d| d[:advanced].present? }
    end

    def self.password_params
      params.reject {|p,d| d[:advanced].blank? }
    end

    params.each do |k,v|
      column k.to_sym, v[:type]
      validates_presence_of k.to_sym
    end

    column :name, :string
    validates_presence_of :name

    column :hostgroup_id, :integer
    belongs_to :hostgroup

    column :environment_id, :integer
    belongs_to :environment

  end
end
