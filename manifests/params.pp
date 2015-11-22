#
# = Class: tomcat::params
#
# This module contains defaults for tomcat modules
#
class tomcat::params {

  $ensure           = 'present'
  $version          = undef
  $service_enable   = true
  $service_ensure   = 'running'
  $autorestart      = true

  $file_mode        = '0644'
  $file_owner       = 'root'
  $file_group       = 'root'

  $java_opts        = ''

  $native_enable    = false
  $native_class     = '::tomcat::native'
  $dependency_class = '::tomcat::dependency'
  $my_class         = undef

  # install package depending on major version
  if $::osfamily == 'redhat' or $::operatingsystem == 'amazon' {
    $package                 = 'tomcat6'
    $service                 = 'tomcat6'
    $file_sysconfig_path     = '/etc/sysconfig/tomcat6'
    $file_sysconfig_template = 'tomcat/sysconfig.tomcat6.erb'
    $native_package          = 'tomcat-native'
  } elsif $::osfamily == 'debian' {
    $package                 = 'tomcat6'
    $service                 = 'tomcat6'
    $file_sysconfig_path     = '/etc/default/tomcat6'
    $file_sysconfig_template = 'tomcat/sysconfig.tomcat6.erb'
    $native_package          = undef
  } else {
    fail("Class['apache::params']: Unsupported operatingsystem: ${::operatingsystem}")
  }
}
# vi:syntax=puppet:filetype=puppet:ts=4:et:nowrap:
