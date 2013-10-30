Deface::Override.new(:virtual_path      => 'subnets/_fields',
                     :name              => 'remove_cluster_subnet_domains',
                     :surround_contents => 'code[erb-loud]:contains("multiple_checkboxes f, :domain")',
                     :text              => <<EOS
unless controller.controller_name == 'clusters'
  <%= render_original %>
end
EOS
)

Deface::Override.new(:virtual_path      => 'subnets/_fields',
                     :name              => 'remove_cluster_subnet_proxies',
                     :surround_contents => 'code[erb-loud]:contains("SmartProxy.")',
                     :text              => <<EOS
unless controller.controller_name == 'clusters'
  <%= render_original %>
end
EOS
)

Deface::Override.new(:virtual_path      => 'subnets/_fields',
                     :name              => 'remove_cluster_subnet_vlan',
                     :surround_contents => 'code[erb-loud]:contains("text_f f, :vlanid")',
                     :text              => <<EOS
unless controller.controller_name == 'clusters'
  <%= render_original %>
end
EOS
)

Deface::Override.new(:virtual_path      => 'subnets/_fields',
                     :name              => 'remove_cluster_subnet_to',
                     :surround_contents => 'code[erb-loud]:contains("text_f f, :to")',
                     :text              => <<EOS
unless controller.controller_name == 'clusters'
  <%= render_original %>
end
EOS
)

Deface::Override.new(:virtual_path      => 'subnets/_fields',
                     :name              => 'remove_cluster_subnet_from',
                     :surround_contents => 'code[erb-loud]:contains("text_f f, :from")',
                     :text              => <<EOS
unless controller.controller_name == 'clusters'
  <%= render_original %>
end
EOS
)
