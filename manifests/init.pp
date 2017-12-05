# == Class: oraclejava
#
#
class oraclejava {
#  class { 'oraclejava::jdk7': }

  class { 'oraclejava::jdk8':
    require => Class['wget'],
  }
#  notify { "Java 8 Installation": }
}
