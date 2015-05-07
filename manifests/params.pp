# puppet::params provides OS specific configuration information

class puppet::params {
  case $::operatingsystem {
    'Gentoo' : {
      $package = ['app-admin/puppet']
      $agent_service = 'puppet'
      $master_service = 'puppetmaster'
      $conf_path = '/etc/puppet/puppet.conf'
    }
    default  : {
      fail("${::operatingsystem} not supported!")
    }
  }
}
