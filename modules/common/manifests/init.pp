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

  package { "pwgen":
    ensure => installed
  }

  exec { "create-empty-var-run-utmp":
    command => "/bin/touch /var/run/utmp && chmod 644 /var/run/utmp && chown root.utmp /var/run/utmp",
    unless => "/usr/bin/test -f /var/run/utmp"
  }

  file { "/etc/apt/sources.list":
    owner => "root",
    group => "root",
    mode => 0444,
    content => template("common/sources.list.erb"),
  }

  exec { "/usr/bin/apt-get update":
    refreshonly => true,
    subscribe => File["/etc/apt/sources.list"],
    require => File["/etc/apt/sources.list"],
  }
}
