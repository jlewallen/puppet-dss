class gerrit {

  group { "gerrit":
    ensure => "present"
  }

  user { "gerrit":
    ensure => "present",
    home => "/home/gerrit",
    gid => "gerrit"
  }

  file { "/home/gerrit":
    ensure => directory
  }
  
  download_file { "gerrit-2.1.6.1.war":
    site => "http://gerrit.googlecode.com/files",
    cwd => "/data"
  }

  exec { "initialize-gerrit":
    command => "/usr/bin/java -jar /data/gerrit-2.1.6.1.war init -d /home/gerrit/review_site",
    cwd => "/home/gerrit",
    unless => "/usr/bin/test -d /home/gerrit/review_site"
  }

  file { "/etc/init.d/gerrit":
    ensure => link,
    target => "/etc/init.d/gerrit.sh",
    require => Exec['initialize-gerrit']
  }

  file { "/etc/default":
    ensure => directory
  }
  
  file { "/etc/default/gerritcodereview":
    content => "export GERRIT_SITE=/home/gerrit/review_site"
  }

  file { [ "/data/gerrit", "/data/gerrit/db", "/data/gerrit/git" ]:
    ensure => directory
  }
  
  # Create the server as a virtual resource, so config instances
  # can enable it.
  @service { gerrit:
     ensure => running,
     enable => true,
     require => File['/etc/init.d/gerrit']
  }
}
