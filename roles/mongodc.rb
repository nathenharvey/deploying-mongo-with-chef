name "mongodc"
description "Sample MongoDB Replica Set for MongoDC"
default_attributes(
  "mongodb" => {
    "replicaset" => "mongodc"
  }
)

run_list(
  "recipe[mongodb::install]",
  "recipe[mongodb::configure]",
  "recipe[mongodb::replica_set]"
)
