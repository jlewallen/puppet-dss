node "server1" {
  include common
  include git
  include lxc
}

node "pfun" {
  include common
  include ebs_backed_data
  include git
  include apache::disabled
  include nginx
  include java
  include jenkins
  include nexus
  include gerrit
  include submin
  include augeas
  include mysql::server

  mysql::database { "gerrit":
    ensure => present,
  }

  nginx::config { main:
    name => 'page5of4.dyndns.org'
  }

  nginx::rproxy::config { gerrit:
    name => 'gerrit',
    path => '/gerrit',
    destination => 'http://127.0.0.1:8082'
  }

  nginx::rproxy::config { jenkins:
    name => 'jenkins',
    path => '/jenkins',
    destination => 'http://127.0.0.1:8080'
  }

  nginx::rproxy::config { nexus:
    name => 'nexus',
    path => '/nexus',
    destination => 'http://127.0.0.1:8081/nexus'
  }

  gerrit::config { gerrit:
    data_path => '/data/gerrit',
    canonical_url => 'http://page5of4.dyndns.org/gerrit'
  }

  file { "/var/www/nginx-default/index.html":
    content => template("menu.html.erb"),
    owner => 'nginx',
    group => 'nginx'
  }
}
