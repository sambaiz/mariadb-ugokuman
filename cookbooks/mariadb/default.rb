package 'mariadb-server'

service 'mariadb' do
  action [:start, :enable]
end

execute "setenforce 0"

remote_file "/etc/my.cnf.d/server.cnf" do
    owner "root"
    group "root"
end

service 'mariadb' do
  action [:restart]
end

execute "mysql_secure_installation + connect from outside" do
  user "root"
  only_if "mysql -u root -e 'show databases' | grep information_schema" # パスワードが空の場合
  command <<-EOL
    mysqladmin -u root password "root"
    mysql -u root -proot -e "DELETE FROM mysql.user WHERE User='';"
    mysql -u root -proot -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1');"
    mysql -u root -proot -e "DROP DATABASE test;"
    mysql -u root -proot -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
    mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.33.1' IDENTIFIED BY 'root' WITH GRANT OPTION;"
    mysql -u root -proot -e "FLUSH PRIVILEGES;"
  EOL
end

%w(mysql).each do |service|
  execute "sudo firewall-cmd --zone public --add-service #{service} --permanent" do
    not_if "sudo firewall-cmd --list-service --zone=public | grep ' #{service} '"
  end
end

execute "sudo firewall-cmd --reload"
