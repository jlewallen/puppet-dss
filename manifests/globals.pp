Exec { path => "/usr/bin:/bin" }

Package {
  provider => 'apt'
}

define download_file($site="", $cwd="") { 
  exec { $name: 
    command => "/usr/bin/wget ${site}/${name}", 
    cwd     => "${cwd}", 
    creates => "${cwd}/${name}",
  } 
}

