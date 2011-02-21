class apache::disabled {
  service { "apache2":
    ensure => stopped,
    # onlyif => Package["apache2"]
  }
}
