class yum::repos::puppetlabs {
    $keyfile    = 'RPM-GPG-KEY-puppetlabs'
    $gpgkey     = "file:///etc/pki/rpm-gpg/${keyfile}"

    file { $keyfile:
        ensure  => present,
        path    => "/etc/pki/rpm-gpg/${keyfile}",
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        source  => "puppet:///modules/yum/puppetlabs/${keyfile}",
    }

    Yumrepo {
        enabled          => 0,
        gpgcheck         => 1,
        metadata_expire  => 7d,
    }

    yumrepo { 'puppetlabs-products':
        descr   => 'Puppet Lab Products - $basesearch',
        baseurl => 'http://yum.puppetlabs.com/el/$releasever/products/$basearch',
        gpgkey  => $gpgkey,
        enabled => 1,
        require => File[$keyfile],
    }

    yumrepo { 'puppetlabs-deps':
        descr   => 'Puppet Labs Dependencies',
        baseurl => 'http://yum.puppetlabs.com/el/$releasever/dependencies/$basearch',
        gpgkey  => $gpgkey,
        enabled => 1,
        require => File[$keyfile],
    }
}
