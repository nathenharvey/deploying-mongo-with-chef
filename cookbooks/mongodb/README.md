Description
===========

Installs and configures 1-n mongo instances for each node.


Attributes
==========

* [:mongodb][:mongods][:mongod] - a unique name for this instance
* [:mongodb][:mongods][:port] - a unique port for this instance
* [:mongodb][:mongods][:replication_set] - the identifier of the replica set that this instance is part of
* [:mongodb][:mongods][:run_backups] - whether or not to run hourly backups
* [:mongodb][:mongods][:rest] - whether or not to make the HTTP Admin interface available
* [:mongodb][:mongods][:monit] - whether or not to configure monit scripts
* [:mongodb][:mongods][:additional_settings] - a hash of additional setting for the mongo configuration file
  
Usage
=====

To add a mongo instance to your node:

* add a recipe file that sets the attributes listed above
* upload your recipe to the server
* run chef-client