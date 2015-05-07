# puppet::common class should not be used by users but is used internally to
# provide common configuration file information.

class puppet::common {
  include puppet::params

  # include concat::setup

  package { $puppet::params::package:
    ensure => installed,
    alias  => 'puppet_package'
  }

  if !defined(Concat[$puppet::params::conf_path]) {
    concat { $puppet::params::conf_path:
      owner => root,
      group => root,
      mode  => '0644',
    }

    concat::fragment { 'puppet_config_header':
      target  => $puppet::params::conf_path,
      content => template('puppet/puppet.conf.common.erb'),
      order   => '100',
    }
  }
}
