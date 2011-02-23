class java {

  # package { "sun-java6-jdk": 
  #  ensure => installed 
  # }

  package { "openjdk-6-jre": 
    ensure => installed 
  }
}
