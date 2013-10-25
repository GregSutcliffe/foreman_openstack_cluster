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
      {
        "verbose"                    => { :default => "true", :type => :boolean },
        "admin_password"             => { :default => SecureRandom.hex, :type => :string },
        "cinder_db_password"         => { :default => SecureRandom.hex, :type => :string },
        "cinder_user_password"       => { :default => SecureRandom.hex, :type => :string },
        "glance_db_password"         => { :default => SecureRandom.hex, :type => :string },
        "glance_user_password"       => { :default => SecureRandom.hex, :type => :string },
        "horizon_secret_key"         => { :default => SecureRandom.hex, :type => :string },
        "keystone_admin_token"       => { :default => SecureRandom.hex, :type => :string },
        "keystone_db_password"       => { :default => SecureRandom.hex, :type => :string },
        "mysql_root_password"        => { :default => SecureRandom.hex, :type => :string },
        "nova_db_password"           => { :default => SecureRandom.hex, :type => :string },
        "nova_user_password"         => { :default => SecureRandom.hex, :type => :string },
        "private_interface"          => { :default => 'PRIV_INTERFACE', :type => :string },
        "public_interface"           => { :default => 'PUB_INTERFACE', :type => :string },
        "fixed_network_range"        => { :default => 'PRIV_RANGE', :type => :string },
        "floating_network_range"     => { :default => 'PUB_RANGE', :type => :string },
        "pacemaker_priv_floating_ip" => { :default => 'PRIV_IP', :type => :string },
        "pacemaker_pub_floating_ip"  => { :default => 'PUB_IP', :type => :string },
        "admin_email"                => { :default => "admin@#{Facter.domain}", :type => :string }
      }
    end

    self.params.each do |k,v|
      column k.to_sym, v[:type]
      validates_presence_of k.to_sym
    end

    column :name, :string
    validates_presence_of :name

  end
end
