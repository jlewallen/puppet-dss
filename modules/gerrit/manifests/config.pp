define gerrit::config($data_path, $canonical_url) {
    file { "/home/gerrit/review_site/etc/gerrit.config":
        content => template("gerrit/gerrit.config.erb"),
        mode => 644,
        owner => "gerrit",
        require => File['/home/gerrit/review_site/etc'],
        notify => Service[gerrit]
    }

    realize Service[gerrit]
}
