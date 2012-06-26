default['init_style'] = 'debian-sysvinit'
default['mongodb']['version']   = '2.0.6'

case platform
when 'debian', 'ubuntu'
  default['mongodb']['package_name'] = 'mongodb-10gen'
  default['mongodb']['service_name'] = "mongodb"
  default['mongodb']['configfile'] = "/etc/mongodb.conf"
when 'centos', 'redhat', 'fedora', 'amazon', 'scientific'
  default['mongodb']['package_name'] = 'mongo-10gen-server'
  default['mongodb']['service_name'] = "mongod"
  default['mongodb']['configfile'] = "/etc/mongod.conf"
end

default['mongodb']['user']  = 'mongodb'
default['mongodb']['group'] = 'mongodb'

default['mongodb']['dbpath']  = '/var/lib/mongodb'
default['mongodb']['logpath'] = '/var/log/mongodb/mongodb.log'
default['mongodb']['port']    = '27017'
default['mongodb']['journal'] = true
default['mongodb']['rest']    = false
default['mongodb']['quiet']   = true
default['mongodb']['httpinterface']   = true

###
default['mongodb']['bind_address'] = '127.0.0.1'


default['mongodb']['backup_dir'] = '/var/lib/mongodb_backups'
default['mongodb']['log_dir']    = '/var/log/mongodb'
default['mongodb']['config_dir'] = '/etc/mongodb'
default['mongodb']['pid_dir']    = '/var/run'

default['mongodb']['run_backups'] = false

default['mongodb']['mongods'] = []

