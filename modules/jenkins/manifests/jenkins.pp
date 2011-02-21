class jenkins {
  exec { "install-jenkins-key":
    command => "/usr/bin/wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add - && apt-get update"
  }

  package { 'jenkins':
    ensure => installed,
    require => Exec["install-jenkins-key"]
  }

  file { "/etc/sysconfig": ensure => directory }

  file { "/etc/sysconfig/jenkins":
    content => 'JENKINS_JAVA_OPTIONS="-Djava.awt.headless=true -Dnet.mdns.interface=0.0.0.0 "',
    require => File["/etc/sysconfig"]
  }

  file { "/etc/default/jenkins":
    content => template("jenkins/jenkins.erb"),
    notify => Service["jenkins"]
  }

  service { 'jenkins':
    provider => debian,
    ensure => running,
    enable => true,
    hasstatus => false,
    hasrestart => true,
    require => [ Package['jenkins'], File["/etc/sysconfig/jenkins"], File["/etc/default/jenkins"] ],
  }
}
