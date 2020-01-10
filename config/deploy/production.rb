server '3.115.222.155', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/mashiyu/.ssh/id_rsa'