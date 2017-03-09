node 'wiki' {
#  class { 'mediawiki': }
#  class { 'linux': }
  hiera_include('classes')
}

node 'wikitest' {
  #hiera_include('classes')
}
class linux {
  $admintools = [ 'nano', 'git','screen' ]
  $ntpservice = $osfamily ? {
    'redhat' => 'ntpd',
    'debian' => 'ntp',
    default =>  'ntp',
  } 
  file { '/info.txt':
    ensure => 'present',
    content => inline_template("Created by puppet at <%= Time.now %>\n "),
   }
  package { $admintools:
    ensure => 'installed',
  }
  service { $ntpservice:
   ensure => 'running',
   enable =>  true,
 }
}
