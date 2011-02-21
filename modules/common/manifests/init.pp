class common {  
  package { "zsh":
    ensure => installed
  }
  package { "screen":
    ensure => installed
  }
  package { "vim":
    ensure => installed
  }
  package { "htop":
    ensure => installed
  }
}
