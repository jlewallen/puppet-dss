class submin {
  exec { "install-submin-key":
    command => "/usr/bin/wget -q -O - http://supermind.nl/debian.key | apt-key add - && apt-get update"
  }

  package { "submin2":
    ensure => installed,
    require => [ File["/etc/apt/sources.list"], Exec["install-submin-key"] ]
  }

}
