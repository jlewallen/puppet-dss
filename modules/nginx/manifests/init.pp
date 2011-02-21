class nginx {
  package { nginx: ensure => installed }

  group { "nginx":
    ensure => "present"
  }

  user { "nginx":
    ensure => "present",
    home => "/var/www/nginx-default",
    gid => "nginx"
  }

  file { "/var/www/nginx-default":
    ensure => directory,
    recurse => true,
    owner => "nginx",
    group => "nginx"
  }

  # Create the server as a virtual resource, so config instances
  # can enable it.
  @service { nginx:
     ensure => running,
     enable => true
  }
}
