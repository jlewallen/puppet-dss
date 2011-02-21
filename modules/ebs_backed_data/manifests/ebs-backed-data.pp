class ebs_backed_data {
  file { "/data":
    ensure => directory
  }
}
