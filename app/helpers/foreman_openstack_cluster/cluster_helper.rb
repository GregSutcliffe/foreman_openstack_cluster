module ForemanOpenstackCluster
  module ClusterHelper
    def method_path method
      send("#{method}_hostgroups_path")
    end
    def param_field f, name, data
      if data[:type] == :boolean
        checkbox_f f, name, :checked => data[:default]
      else
        text_f f, name, :class => "span5",
          :placeholder => data[:placeholder],
          :help_inline => data[:description]
      end
    end

  end
end
