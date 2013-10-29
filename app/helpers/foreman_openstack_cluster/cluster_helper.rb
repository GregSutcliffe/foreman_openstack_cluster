module ForemanOpenstackCluster
  module ClusterHelper
    def method_path method
      send("#{method}_hostgroups_path")
    end
    def param_field f, name, data
      text_f f, name, :class => "span5",
        :placeholder => data[:placeholder],
        :help_inline => data[:description]
    end

  end
end
