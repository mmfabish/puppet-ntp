class ntp {

  $service_name = $facts['osfamily'] ? {
    'RedHat' => 'ntpd',
    default  => 'ntp',
  }
  
  package { 'ntp':
    ensure => installed,
  }

  file { 'ntp.conf':
    name => '/etc/ntp.conf',
    ensure => file,
    require => Package['ntp'],
    source => "puppet:///modules/ntp/ntp.conf",
  }

  service { 'ntp':
    name => $service_name,
    ensure => running,
    enable => true,
    subscribe => File['ntp.conf'],
  }
}
