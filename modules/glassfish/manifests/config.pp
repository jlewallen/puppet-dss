define glassfish::domain($instanceport) {

  $glassfish_dir = "/usr/local/glassfish"

  exec { "create-domain":
    command => "$glassfish_dir/bin/asadmin --user admin --passwordfile=/usr/local/glassfish/.aspass create-domain --instanceport $instanceport $name",
    require => File[$glassfish_dir],
    unless => "/usr/bin/test -d $glassfish_dir/glassfish/domains/$name",
    notify => Service["glassfish"]
  }

  file { "$glassfish_dir/glassfish/domains/$name":
    owner => "glassfish",
    group => "glassfish",
    recurse => true,
    require => Exec["create-domain"],
    notify => Service["glassfish"]
  }

  realize Service["glassfish"]
}
