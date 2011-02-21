define nginx::config() {
    file { "/etc/nginx/nginx.conf":
        content => template("nginx/nginx.conf.erb"),
        mode => 644,
        owner => root,
        notify => Service[nginx]
    }

    realize Service[nginx]
}

define nginx::app::config($name) {
    file { "/etc/nginx/apps/$name.conf":
        content => template("nginx/app.simple.conf.erb"),
        mode => 644,
        owner => root,
        notify => Service[nginx]
    }

    realize Service[nginx]
}

define nginx::rproxy::config($name, $path, $destination) {
    file { "/etc/nginx/apps/$name.conf":
        content => template("nginx/app.rproxy.conf.erb"),
        mode => 644,
        owner => root,
        notify => Service[nginx]
    }

    realize Service[nginx]
}
