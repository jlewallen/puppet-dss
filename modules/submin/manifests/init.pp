class submin {
  exec { "install-key":
    command => "/usr/bin/wget -q -O - http://supermind.nl/debian.key | apt-key add -"
  }

  package { "submin2":
    ensure => installed,
    require => File["/etc/apt/sources.list"]
  }

}
