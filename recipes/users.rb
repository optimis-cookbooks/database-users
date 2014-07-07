include_recipe 'database'

name = node.name
configuration = data_bag_item 'database', name

configuration['databases'].each do |database|
  database['users'].each do |user|
    mysql_database_user user['username'] do
      connection({ :host => 'localhost', :username => 'root', :password => node['mysql']['server_root_password'] })
      password user['password']
      action :create
    end

    mysql_database_user user['username'] do
      connection({ :host => 'localhost', :username => 'root', :password => node['mysql']['server_root_password'] })
      host user['host']
      password user['password']
      privileges user['privileges']
      action :grant
    end
  end
end
