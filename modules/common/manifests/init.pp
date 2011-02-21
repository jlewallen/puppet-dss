class common {  
  package { "zsh":
    ensure => installed
  }
  package { "screen":
    ensure => installed
  }
  package { "vim":
    ensure => installed
  }
  package { "htop":
    ensure => installed
  }

  file { "/etc/apt/sources.list":
    owner => "root",
    group => "root",
    mode => 0444,
    content => template("common/sources.list.erb"),
  }

  exec{"/usr/bin/apt-get update":
    refreshonly => true,
    subscribe => File["/etc/apt/sources.list"],
    require => File["/etc/apt/sources.list"],
  }
}
