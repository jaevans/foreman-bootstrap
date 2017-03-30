node 'default' {
  class { 'r10k':
    remote => 'CONTROL_REPO'
  }

  class {'hiera':
        hierarchy => ['nodes/%{::trusted.certname}','virtual', 'common'],
  }

  # Configure epel, excluding passenger bits. They conflict with Foreman's ruby and setup
  class {'epel':
    epel_exclude =>  'passenger*,mod_passenger*',
  }
}
