# puppet::master class should be used to configure a Puppet master.

class puppet::master ($autosign = false, $reports = 'store',
  $storeconfigs = false) {
  include puppet::common

  service { $puppet::params::master_service:
    ensure    => running,
    enable    => true,
    require   => [Package['puppet_package']],
    subscribe => [File[$puppet::params::conf_path]],
  }

  concat::fragment { 'puppet_config_master':
    target  => $puppet::params::conf_path,
    content => template('puppet/puppet.conf.master.erb'),
    order   => '200',
  }
}
