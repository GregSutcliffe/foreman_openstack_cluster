namespace :test do
  desc "Test OpenstackCluster plugin"
  Rake::TestTask.new(:openstack_cluster) do |t|
    test_dir = File.join(File.dirname(__FILE__), '..', 'test')
    t.libs << ["test",test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
  end

end

Rake::Task[:test].enhance do
  Rake::Task['test:openstack_cluster'].invoke
end

