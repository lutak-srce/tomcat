#
# = Class: tomcat
#
# This module manages Tomcat installation
#
class tomcat (
  $ensure                  = $::tomcat::params::ensure,
  $package                 = $::tomcat::params::package,
  $version                 = $::tomcat::params::version,
  $service                 = $::tomcat::params::service,
  $service_enable          = $::tomcat::params::service_enable,
  $service_ensure          = $::tomcat::params::service_ensure,
  $file_mode               = $::tomcat::params::file_mode,
  $file_owner              = $::tomcat::params::file_owner,
  $file_group              = $::tomcat::params::file_group,
  $file_sysconfig_path     = $::tomcat::params::file_sysconfig_path,
  $file_sysconfig_template = $::tomcat::params::file_sysconfig_template,
  $java_opts               = $::tomcat::params::java_opt,
  $native_enable           = $::tomcat::params::native_enable,
  $native_class            = $::tomcat::params::native_class,
  $dependency_class        = $::tomcat::params::dependency_class,
  $my_class                = $::tomcat::params::my_class,
  $noops                   = undef,
) inherits tomcat::params {

  ### Input parameters validation
  validate_re($ensure, ['present','absent'], 'Valid values are: present, absent')
  validate_string($package)
  validate_string($version)
  validate_string($service)

  ### Internal variables (that map class parameters)
  if $ensure == 'present' {
    $package_ensure = $version ? {
      ''      => 'present',
      default => $version,
    }
    $file_ensure = present
  } else {
    $file_ensure = absent
  }

  ### Extra classes
  if $dependency_class { include $dependency_class }
  if $my_class         { include $my_class         }

  ### Native Extension
  if ( $native_enable ) { include $native_class }

  ### Resources
  package { 'tomcat':
    ensure => $package_ensure,
    name   => $package,
    noop   => $noops,
  }

  service { 'tomcat':
    ensure  => $service_ensure,
    enable  => $service_enable,
    name    => $service,
    require => Package['tomcat'],
    noop    => $noops,
  }

  ### set defaults for file resource in this scope.
  File {
    ensure  => $file_ensure,
    owner   => $file_owner,
    group   => $file_group,
    mode    => $file_mode,
    notify  => Service['tomcat'],
    noop    => $noops,
  }

  file { $file_sysconfig_path :
    content => template($file_sysconfig_template),
  }

}
# vi:syntax=puppet:filetype=puppet:ts=4:et:nowrap:
