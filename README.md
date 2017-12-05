oraclejava
==========

Puppet module to install Oracle JDK 9, 8, 7 or 6 by downloaded from the java oracle website.

NOTE: JRE not yet supported. Install relies on wget being installed

Minimal Usage
=============

Install Java JDK7u79:

      class { 'oraclejava' : }

Install Java JDK7u79 via rpm:

      class { 'oraclejava::jdk7_rpm' : }

Install Java JDK8u71:

      class { 'oraclejava::jdk8' : }

Install Java JDK8u71 via rpm:

      class { 'oraclejava::jdk8_rpm' : }

Install Java JDK9b102:

      class { 'oraclejava::jdk9' : }

Complex Usage
=============

Install Java JDK9b72

      class { 'oraclejava::jdk9' :
        java           => 'jdk-8b72',
        java_loc        => '/usr/java',
        java_dir        => 'jdk1.9.0_b72',
        download_url    => 'http://www.java.net/download/jdk9/archive/b72/binaries/jdk-9-ea-bin-b72-linux-x64-08_jul_2015.tar.gz'
      }

Install Java JDK8u11

      class { 'oraclejava::jdk8' :
        java           => 'jdk-8u11',
        java_loc        => '/usr/java',
        java_dir        => 'jdk1.8.0_11',
        download_url    => 'http://download.oracle.com/otn-pub/java/jdk/8u11-b01/jdk-8u11-linux-x64.tar.gz'
      }

Install Java JDK8u11 via rpm

      class { 'oraclejava::jdk8_rpm' :
        java_loc        => '/usr/java',
        java_dir        => 'jdk1.8.0_11',
        rpm_name        => 'jdk-8u11-linux-x64.rpm',
        download_url    => 'http://download.oracle.com/otn-pub/java/jdk/8u11-b01/jdk-8u11-linux-x64.rpm'
      }

Install Java JDK7u67 via rpm and an http proxy 10.99.99.99

     class { 'oraclejava::jdk7_rpm':
       java_loc        => '/usr/java',
       java_dir        => 'jdk1.7.0_67',
       rpm_name        => 'jdk-7u67-linux-x64.rpm',
       download_url    => 'https://edelivery.oracle.com/otn-pub/java/jdk/7u67-b01/jdk-7u67-linux-x64.rpm',
       wget_opts       => "-e use_proxy=yes -e http_proxy=10.99.99.99:3128  -e https_proxy=10.99.99.99:3128",
       require         => Class['epel']
     }


To determine the values for latest release of Java versions:

https://jdk9.java.net/download/

http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html


To determine the values for older releases of Java versions:

http://www.oracle.com/technetwork/java/javase/downloads/java-archive-javase8-2177648.html

http://www.oracle.com/technetwork/java/javase/downloads/java-archive-downloads-javase7-521261.html

http://www.oracle.com/technetwork/java/javasebusiness/downloads/java-archive-downloads-javase6-419409.html
