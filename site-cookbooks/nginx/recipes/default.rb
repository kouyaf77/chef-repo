package "nginx" do
  action :install
end

service "nginx" do
  supports status: true, restart: true, reload: true

  action [:enable, :start]
end

template "nginx.conf" do
  owner "root"
  group "root"
  mode 0644

  notifies :reload, "service[nginx]"
end
