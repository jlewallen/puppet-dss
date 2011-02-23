class glassfish {
  file { "/data": ensure => directory }

  $glassfish_filename = "glassfish-3.0.1.zip"

  group { "glassfish":
    ensure => "present"
  }

  user { "glassfish":
    ensure => "present",
    home => "/usr/local/glassfish",
    gid => "glassfish"
  }

  file { [ "/usr/local" ]:
    ensure => directory
  }

  download_file { $glassfish_filename:
    site => "http://download.java.net/glassfish/3.0.1/release/$glassfish_filename",
    cwd => "/data",
    require => [ File["/data"], Class["java"] ]
  }

  exec { "glassfish-extraction":
    command => "/usr/bin/unzip /data/$glassfish_filename && rm -rf glassfishv3/glassfish/domains/* && chown -R glassfish. glassfishv3",
    cwd => "/usr/local",
    unless => "/usr/bin/test -d /usr/local/glassfishv3",
    require => [ File["/usr/local"], Exec[$glassfish_filename] ]
  }

  file { "/usr/local/glassfish/.aspass":
    ensure => present,
    content => "AS_ADMIN_USER=admin\nAS_ADMIN_PASSWORD=",
    require => File["/usr/local/glassfish"]
  }

  file { "/usr/local/glassfishv3":
    ensure => directory,
    owner => "glassfish",
    group => "glassfish",
    recurse => true,
    require => Exec["glassfish-extraction"]
  }

  file { "/usr/local/glassfish":
    ensure => link,
    target => "glassfishv3",
    require => Exec["glassfish-extraction"]
  }

  file { "/etc/init.d/glassfish":
    content => template("glassfish/glassfish.init.erb"),
    mode => 755,
    require => File["/usr/local/glassfish"]
  }

  @service { "glassfish":
    ensure => running,
    enable => true,
    hasstatus => false,
    hasrestart => false,
    require => File["/etc/init.d/glassfish"]
  }
}
