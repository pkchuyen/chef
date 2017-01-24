package "nginx" do
    :upgrade
end

# --- Ensure requires services running ---
service "nginx" do
  enabled true
  running true
  supports :status => true, :restart => true, :reload => true
  action [:start, :enable]
end

# --- Deploy a configuration file ---
cookbook_file '/etc/nginx/conf.d/app.example.com.conf' do
  verify 'nginx -t -c /etc/nginx/nginx.conf'
  notifies :reload, 'service[nginx]', :delayed
end