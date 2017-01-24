# log_level :debug
log_location "/var/log/chef.log"
file_store_path File.join(File.dirname(__FILE__), "cache")
file_cache_path File.join(File.dirname(__FILE__), "cache")
cookbook_path [
    File.join(File.dirname(__FILE__), "/cookbooks"),
    File.join(File.dirname(__FILE__), "/site-cookbooks")
]
