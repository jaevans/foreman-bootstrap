node 'default' {
  class { 'r10k':
    remote => 'http://gogs.universe.lan/milamber/control.git',
  }

  class {'hiera':
        hierarchy => ['nodes/%{::trusted.certname}','virtual', 'common'],
  }
}
