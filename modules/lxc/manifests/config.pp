define lxc::container($name, $network) {
    file { "/var/lib/lxc/$name":
        ensure => directory
    }

    file { "/var/lib/lxc/$name/fstab":
      ensure => present,
      content => template("lxc/container.fstab.erb"),
      require => File["/var/lib/lxc/$name"]
    }

    file { "/var/lib/lxc/$name/config":
      ensure => present,
      content => template("lxc/container.config.erb"),
      require => File["/var/lib/lxc/$name"]
    }

    file { "/var/lib/lxc/$name/rootfs":
      ensure => directory,
      require => File["/var/lib/lxc/$name"]
    }
}
