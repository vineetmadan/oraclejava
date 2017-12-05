# == Class: oraclejava::jdk7_rpm
#
# install oracle java jdk 7
#
#
class oraclejava::jdk7_rpm (
  $java_loc     = '/usr/java',
  $java_dir     = 'jdk1.7.0_79',
  $rpm_name     = 'jdk-7u79-linux-x64.rpm',
  $download_url = 'http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.rpm',
  $download_dir = '/tmp',
  $wget_opts    = '',
  $cookie       = 'oraclelicense=accept-securebackup-cookie'
)
{

  file { $java_loc:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  exec { 'download_oracle_jdk7_rpm':
    cwd     => $java_loc,
    creates => "${java_loc}/${rpm_name}",
    command => "wget ${wget_opts} --no-cookies --no-check-certificate --header \"Cookie: ${cookie}\" \"${download_url}\"",
    timeout => 0,
    require => File[$java_loc],
  }

  exec { 'install_oracle_jdk7_rpm':
    cwd     => $java_loc,
    creates => "${java_loc}/${java_dir}",
    command => "yum -y install \"${java_loc}/${rpm_name}\"",
    require => Exec['download_oracle_jdk7_rpm'],
    timeout => 0
  }

}

