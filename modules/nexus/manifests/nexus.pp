class nexus {
  download_file { "nexus-oss-webapp-1.9-bundle.tar.gz":
    site => "http://nexus.sonatype.org/downloads",
    cwd => "/data"
  }

  file { [ "/usr/local", "/data/nexus", "/data/nexus/sonatype-work" ]:
    ensure => directory
  }

  exec { "nexus-extraction":
    command => '/bin/tar zxf /data/nexus-oss-webapp-1.9-bundle.tar.gz',
    cwd => "/usr/local",
    unless => "/usr/bin/test -d /usr/local/nexus"
  }

  file { "/usr/local/nexus":
    ensure => link,
    target => "nexus-oss-webapp-1.9",
  }

  file { "/usr/local/sonatype-work":
    ensure => link,
    force => true,
    target => "/data/nexus/sonatype-work",
  }

  file { "/etc/init.d/nexus":
    ensure => link,
    target => "/usr/local/nexus/bin/jsw/linux-x86-32/nexus",
  }

  service { 'nexus':
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
    require => File["/etc/init.d/nexus"]
  }
}

