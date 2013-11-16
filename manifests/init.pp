class yum (
    $proxy      = false,
    $proxy_host = "http://proxy.${::domain}:3128",
    $extrarepo  = ['epel'] 
) {

    validate_array($extrarepo)

    if $::osfamily != 'redhat' {
        fail("${::operatingsystem} is not a Redhat based system")
    }

    if $proxy {
        file_line { 'http_proxy':
            ensure  => present,
            path    => '/etc/yum.conf',
            line    => "proxy=${proxy_host}",
            require => File['yum.conf'],
        }
    }

    package {
        'yum': ensure => present;
        'rpm': ensure => present;
    }

    file { 'yum':
        ensure => directory,
        path   => '/etc/yum',
        owner  => root,
        group  => root,
        mode   => '0755',
    }
    
    file { 'yum.repos.d':
        ensure => directory,
        path   => '/etc/yum.repos.d',
        owner  => root,
        group  => root,
        mode   => '0755',
    }

    file { 'yum.conf':
        ensure => present,
        path   => '/etc/yum.conf',
        owner  => root,
        group  => root,
        mode   => '0644',
    }

    file { 'rpm_gpg':
        ensure => directory,
        path   => '/etc/pki/rpm-gpg',
        owner  => root,
        group  => root,
        mode   => '0644',
    }

    if $yum::extrarepo =~ /epel/ { include yum::repos::epel }
    if $yum::extrarepo =~ /puppetlabs/ and $::operatingsystemrelease !~ /^4/ { include yum::repos::puppetlabs }
}
