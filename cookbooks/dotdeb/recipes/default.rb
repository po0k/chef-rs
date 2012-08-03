bash "dotdeb keys" do
  code <<-EOH
gpg --keyserver keyserver.ubuntu.com --recv-key 89DF5277
gpg -a --export 89DF5277 | apt-key add -
EOH
  action :run
end

execute "apt-get update" do
  action :run
end

cookbook_file "/etc/apt/sources.list.d/dotdeb.list" do
  source "dotdeb.list"
  mode 0644
  owner "root"
  group "root"
  notifies :run, "bash[dotdeb keys]", :immediately
  notifies :run, "execute[apt-get update]", :immediately
end
