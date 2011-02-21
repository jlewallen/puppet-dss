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

  file { "/data/gerrit-2.1.6.1.war":
    require => Exec["gerrit-2.1.6.1.war"]
  }

  exec { "initialize-gerrit":
    command => "/usr/bin/java -jar /data/gerrit-2.1.6.1.war init -d /home/gerrit/review_site",
    cwd => "/home/gerrit",
    unless => "/usr/bin/test -d /home/gerrit/review_site/etc",
    require => [ File["/data/gerrit-2.1.6.1.war"], Package["openjdk-6-jre"] ]
  }

  file { "/home/gerrit/review_site":
    ensure => directory
  }

  file { "/home/gerrit/review_site/git":
    ensure => link,
    require => File["/home/gerrit/review_site"],
    target => "/data/gerrit/git",
  }

  file { "/home/gerrit/review_site/db":
    ensure => link,
    require => File["/home/gerrit/review_site"],
    target => "/data/gerrit/db",
  }

  file { "/home/gerrit/review_site/etc":
    require => [ File["/home/gerrit/review_site/git"], File["/home/gerrit/review_site/db"], Exec["initialize-gerrit"] ]
  }

  file { "/etc/init.d/gerrit":
    ensure => link,
    target => "/home/gerrit/review_site/bin/gerrit.sh",
    require => File['/home/gerrit/review_site/etc']
  }
  
  file { "/etc/default": ensure => directory }
  file { "/etc/default/gerritcodereview":
    content => "export GERRIT_SITE=/home/gerrit/review_site",
    require => File['/etc/default']
  }

  file { [ "/data/gerrit", "/data/gerrit/db", "/data/gerrit/git" ]:
    ensure => directory,
    owner => 'gerrit',
    group => 'gerrit',
    recurse => true
  }
  
  # Create the server as a virtual resource, so config instances
  # can enable it.
  @service { gerrit:
     ensure => running,
     enable => true,
     require => [
       File["/data/gerrit/db"],
       File["/data/gerrit/git"],
       File['/etc/init.d/gerrit'],
       File['/etc/default/gerritcodereview'],
       Exec["initialize-gerrit"]
     ]
  }
}
