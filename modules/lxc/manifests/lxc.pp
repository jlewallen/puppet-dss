class lxc {
  package { "lxc": 
    ensure => installed 
  }

  # none /cgroup cgroup defaults 0 0
  file { "/cgroup":
    ensure => directory
  }

  mount { "/cgroup": 
    ensure => "mounted",
    device => "none",
    fstype => "cgroup", 
    options => "default", 
    remounts => false,
    require => File["/cgroup"]
  } 

  # setup bridge
  file { "/etc/network/interfaces":
    content => template("lxc/interfaces.erb"),
    owner => "root",
    group => "root",
    notify => Service["networking"]
  }

  service { "networking":
    ensure => "running",
    hasstatus => "true",
    hasrestart => "true",
    restart => "/etc/init.d/networking restart",
  }
}
