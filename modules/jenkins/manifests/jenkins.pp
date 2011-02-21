class jenkins {
  exec { "install-jenkins-key":
    command => "/usr/bin/wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add - && apt-get update"
  }

  package { 'jenkins':
    ensure => installed,
    require => Exec["install-jenkins-key"]
  }

  service { 'jenkins':
    provider => debian,
    ensure => running,
    enable => true,
    hasstatus => false,
    hasrestart => true,
    require => Package['jenkins'],
  }
}
