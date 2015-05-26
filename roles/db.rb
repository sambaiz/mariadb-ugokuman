%w(firewalld mariadb).each do |cookbook|
  include_recipe "../cookbooks/#{cookbook}/default.rb"
end
