# puppet::agent class should be used to configure a Puppet agent.

class puppet::agent ($server, $runinterval = '15m', $report = true) {
  include puppet::common

  service { $puppet::params::agent_service:
    ensure    => running,
    enable    => true,
    require   => [Package['puppet_package']],
    subscribe => [File[$puppet::params::conf_path]],
  }

  concat::fragment { 'puppet_config_agent':
    target  => $puppet::params::conf_path,
    content => template('puppet/puppet.conf.agent.erb'),
    order   => '300',
  }
}
