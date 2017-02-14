node 'default' {
  class { 'r10k':
    remote => 'http://gogs.universe.lan/milamber/control.git',
  }

  class {'hiera':
        hierarchy => ['nodes/%{::trusted.certname}','virtual', 'common'],
  }

  # Configure epel, excluding passenger bits. They conflict with Foreman's ruby and setup
  class {'epel':
    epel_exclude => [ 'passenger*', 'mod_passenger*' ],
  }
}
