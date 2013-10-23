$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "foreman_openstack_cluster/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = %q{foreman_openstack_cluster}
  s.version     = ForemanOpenstackCluster::VERSION
  s.authors = ["Greg Sutcliffe"]
  s.email = %q{gsutclif@redhat.com}
  s.description = %q{A UI for entering parameters to create related Hostgroups}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = Dir["{app,extra,config,db,lib}/**/*"] + ["LICENSE", "README.md"]
  s.test_files = Dir["test/**/*"]
  s.homepage = %q{http://github.com/GregSutcliffe/foreman_openstack_cluster}
  s.licenses = ["GPL-3"]
  s.summary = %q{Openstack Clustering Plugin for Foreman}

  s.add_dependency "deface"
end
