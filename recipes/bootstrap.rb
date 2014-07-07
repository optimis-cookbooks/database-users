include_recipe 'mysql::server'

name = node.name
configuration = data_bag_item 'database', name

configuration['databases'].each do |database|
  mysql_database database['name'] do
    connection({ :host => 'localhost', :username => 'root', :password => node['mysql']['server_root_password'] })
    action :create
  end
end
