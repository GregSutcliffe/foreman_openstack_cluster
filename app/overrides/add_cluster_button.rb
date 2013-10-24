Deface::Override.new(
  :virtual_path => "hostgroups/index",
  :name => "openstack_cluster_button",
  :replace => "erb[silent]:contains('help_path')",
  :text => "<% title_actions display_link_if_authorized(_(\"New Host Group\"), hash_for_new_hostgroup_path ), (link_to _(\"New Openstack Cluster\"), new_foreman_openstack_cluster_cluster_path) , help_path %>"
)
