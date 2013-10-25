module ForemanOpenstackCluster
  module ClusterHelper
    def method_path method
      send("#{method}_hostgroups_path")
    end
  end
end
