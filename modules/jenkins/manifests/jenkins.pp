class jenkins {
  package { 'jenkins':
    ensure => installed
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
