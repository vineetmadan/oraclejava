# == Class: oraclejava::jdk9
#
# install oracle java jdk 9
#
#

class oraclejava::jdk9 (
  $java         = 'jdk-9-b111',
  $java_loc     = '/usr/java',
  $java_dir     = 'jdk-9.0.1',
  $download_url = 'http://download.oracle.com/otn-pub/java/jdk/9.0.1+11/jdk-9.0.1_linux-x64_bin.tar.gz',
#  $download_url = 'http://www.java.net/download/jdk9/archive/102/binaries/jdk-9-ea+102_linux-x86_bin.tar.gz',
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

  exec {'remove_download_oracle_jdk9':
    command => "rm -f ${download_dir}/${java}-linux-x64.tar.gz*",
    cwd     => $download_dir,
    onlyif  => "test -f ${download_dir}/${java}-linux-x64.tar.gz*",
    path     => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    require => File[$java_loc]
  }

  exec { 'download_oracle_jdk9':
    command => "wget ${wget_opts} --no-cookies --no-check-certificate --header \"Cookie: ${cookie}\" \"${download_url}\" -O \"${download_dir}/${java}-linux-x64.tar.gz\"",
    creates => "${download_dir}/${java}-linux-x64.tar.gz",
    cwd     => $download_dir,
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    timeout => 0,
    require => Exec['remove_download_oracle_jdk9']
  }

  file { "${download_dir}/${java}-linux-x64.tar.gz":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0750',
    require =>Exec['download_oracle_jdk9']
  }

  exec { 'explode_oracle_jdk9':
    command => "tar xvf ${java}-linux-x64.tar.gz",
    creates => "${download_dir}/${java_dir}",
    cwd     => $download_dir,
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    require => [File["${download_dir}/${java}-linux-x64.tar.gz"],File[$java_loc]]
  }

  file { "${java_loc}/${java_dir}":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0755',
    source  => "${download_dir}/${java_dir}",
    recurse => true,
    require => Exec['explode_oracle_jdk9']
  }

  exec { 'link_jar9':
    command => "ln -s ${java_loc}/${java_dir}/bin/jar /usr/bin/jar",
    creates => '/usr/bin/jar',
    cwd     => '/usr/bin',
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_java9':
    command => "ln -s ${java_loc}/${java_dir}/bin/java /usr/bin/java",
    creates => '/usr/bin/java',
    cwd     => '/usr/bin',
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_javac9':
    command => "ln -s ${java_loc}/${java_dir}/bin/javac /usr/bin/javac",
    creates => '/usr/bin/javac',
    cwd     => '/usr/bin',
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_javadoc9':
    command => "ln -s ${java_loc}/${java_dir}/bin/javadoc /usr/bin/javadoc",
    creates => '/usr/bin/javadoc',
    cwd     => '/usr/bin',
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_javaws9':
    command => "ln -s ${java_loc}/${java_dir}/bin/javaws /usr/bin/javaws",
    creates => '/usr/bin/javaws',
    cwd     => '/usr/bin',
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_jcontrol9':
    command => "ln -s ${java_loc}/${java_dir}/bin/jcontrol /usr/bin/jcontrol",
    creates => '/usr/bin/jcontrol',
    cwd     => '/usr/bin',
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    require => File["${java_loc}/${java_dir}"]
  }

}
