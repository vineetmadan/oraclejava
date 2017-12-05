# == Class: oraclejava::jdk8
#
# install oracle java jdk 8
#
#

class oraclejava::jdk8 (
  $java         = 'jdk-8u151',
  $java_loc     = '/usr/java',
  $java_dir     = 'jdk1.8.0_151',
  $download_url =  'http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz',
#  $download_url = 'http://download.oracle.com/otn-pub/java/jdk/8u71-b15/jdk-8u71-linux-x64.tar.gz',
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

  exec {'remove_download_oracle_jdk8':
    command => "rm -f ${download_dir}/${java}-linux-x64.tar.gz?*",
    cwd     => $download_dir,
    onlyif  => "test -f ${download_dir}/${java}-linux-x64.tar.gz?*",
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    require => File[$java_loc]
  }

  exec { 'download_oracle_jdk8':
    command => "wget ${wget_opts} --no-cookies --no-check-certificate --header \"Cookie: ${cookie}\" \"${download_url}\"",
    creates => "${download_dir}/${java}-linux-x64.tar.gz",
    cwd     => $download_dir,
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    timeout => 0,
    require => Exec['remove_download_oracle_jdk8']
  }

  exec { 'rename_oracle_jdk8':
    command => "mv ${java}-linux-x64.tar.gz?* ${java}-linux-x64.tar.gz",
    creates => "${download_dir}/${java}-linux-x64.tar.gz",
    cwd     => $download_dir,
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    require => Exec['download_oracle_jdk8']
  }

  file { "${download_dir}/${java}-linux-x64.tar.gz":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0750',
    require => Exec['rename_oracle_jdk8']
  }

  exec { 'explode_oracle_jdk8':
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
    require => Exec['explode_oracle_jdk8']
  }

  exec { 'link_jar8':
    command => "ln -s ${java_loc}/${java_dir}/bin/jar /usr/bin/jar",
    creates => '/usr/bin/jar',
    cwd     => '/usr/bin',
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_java8':
    command => "ln -s ${java_loc}/${java_dir}/bin/java /usr/bin/java",
    creates => '/usr/bin/java',
    cwd     => '/usr/bin',
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_javac8':
    command => "ln -s ${java_loc}/${java_dir}/bin/javac /usr/bin/javac",
    creates => '/usr/bin/javac',
    cwd     => '/usr/bin',
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_javadoc8':
    command => "ln -s ${java_loc}/${java_dir}/bin/javadoc /usr/bin/javadoc",
    creates => '/usr/bin/javadoc',
    cwd     => '/usr/bin',
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_javaws8':
    command => "ln -s ${java_loc}/${java_dir}/bin/javaws /usr/bin/javaws",
    creates => '/usr/bin/javaws',
    cwd     => '/usr/bin',
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_jcontrol8':
    command => "ln -s ${java_loc}/${java_dir}/bin/jcontrol /usr/bin/jcontrol",
    creates => '/usr/bin/jcontrol',
    cwd     => '/usr/bin',
    path    => ['/usr/bin','/usr/sbin','/bin','/sbin'],
    require => File["${java_loc}/${java_dir}"]
  }

}
