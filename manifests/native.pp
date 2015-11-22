#
# = Class: tomcat::native
#
# This module manages Tomcat native extension installation
#
class tomcat::native (
  $ensure                  = $::tomcat::params::ensure,
  $package                 = $::tomcat::params::native_package,
  $version                 = $::tomcat::params::native_version,
  $noops                   = undef,
) inherits tomcat::params {

  ### Input parameters validation
  validate_re($ensure, ['present','absent'], 'Valid values are: present, absent')
  validate_string($package)
  validate_string($version)

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

  ### Resources
  package { 'tomcat-native':
    ensure => $package_ensure,
    name   => $package,
    noop   => $noops,
  }

}
# vi:syntax=puppet:filetype=puppet:ts=4:et:nowrap:
