#
# = Class: tomcat::dependency
#
# This module contains dependencies for Tomcat
#
class tomcat::dependency {
  include ::java::openjdk8
}
# vi:syntax=puppet:filetype=puppet:ts=4:et:nowrap:
