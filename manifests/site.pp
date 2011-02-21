define download_file($site="", $cwd="") { 
  exec { $name: 
    command => "/usr/bin/wget ${site}/${name}", 
    cwd     => "${cwd}", 
    creates => "${cwd}/${name}",
  } 
}

import "modules"
import "templates"
import "nodes"

