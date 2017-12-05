# == Class: oraclejava::jdk6
#
# install oracle java jdk 6
#
#

class oraclejava::jdk6 (
  $java         = 'jdk-6u45',
  $java_loc     = '/usr/java',
  $java_dir     = 'jdk1.6.0_45',
  $download_url = 'https://edelivery.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-x64.bin',
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

  exec {'remove_download_oracle_jdk6':
    command => "rm -f ${download_dir}/${java}-linux-x64.tar.gz?*",
    cwd     => $download_dir,
    require => File[$java_loc]
  }

  exec { 'download_oracle_jdk6':
    command => "wget ${wget_opts} --no-cookies --no-check-certificate --header \"Cookie: ${cookie}\" \"${download_url}\"",
    creates => "${download_dir}/${java}-linux-x64.bin",
    cwd     => $download_dir,
    timeout => 0,
    require => Exec['remove_download_oracle_jdk6']
  }

  exec { 'rename_oracle_jdk6':
    command => "mv ${java}-linux-x64.bin?* ${java}-linux-x64.bin",
    creates => "${download_dir}/${java}-linux-x64.bin",
    cwd     => $download_dir,
    require => Exec['download_oracle_jdk6']
  }

  file { "${download_dir}/${java}-linux-x64.bin":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0750',
    require => Exec['rename_oracle_jdk6']
  }

  exec { 'explode_oracle_jdk6':
    command => "${download_dir}/${java}-linux-x64.bin",
    creates => "${download_dir}/${java_dir}",
    cwd     => $download_dir,
    require => File["${download_dir}/${java}-linux-x64.bin"]
  }

  file { "${java_loc}/${java_dir}":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0755',
    source  => "${download_dir}/${java_dir}",
    recurse => true,
    require => Exec['explode_oracle_jdk6']
  }

  exec { 'link_jar6':
    command => "ln -s ${java_loc}/${java_dir}/bin/jar /usr/bin/jar",
    creates => '/usr/bin/jar',
    cwd     => '/usr/bin',
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_java6':
    command => "ln -s ${java_loc}/${java_dir}/bin/java /usr/bin/java",
    creates => '/usr/bin/java',
    cwd     => '/usr/bin',
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_javac6':
    command => "ln -s ${java_loc}/${java_dir}/bin/javac /usr/bin/javac",
    creates => '/usr/bin/javac',
    cwd     => '/usr/bin',
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_javadoc6':
    command => "ln -s ${java_loc}/${java_dir}/bin/javadoc /usr/bin/javadoc",
    creates => '/usr/bin/javadoc',
    cwd     => '/usr/bin',
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_javaws6':
    command => "ln -s ${java_loc}/${java_dir}/bin/javaws /usr/bin/javaws",
    creates => '/usr/bin/javaws',
    cwd     => '/usr/bin',
    require => File["${java_loc}/${java_dir}"]
  }

  exec { 'link_jcontrol6':
    command => "ln -s ${java_loc}/${java_dir}/bin/jcontrol /usr/bin/jcontrol",
    creates => '/usr/bin/jcontrol',
    cwd     => '/usr/bin',
    require => File["${java_loc}/${java_dir}"]
  }

}

