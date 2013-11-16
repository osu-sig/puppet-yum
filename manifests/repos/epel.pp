class yum::repos::epel($userelease = false) {
    $osver      = inline_template("<%= operatingsystemrelease.split('.')[0] %>")
    $keyfile    = "RPM-GPG-KEY-EPEL-${osver}"
    $gpgkey     = "file:///etc/pki/rpm-gpg/${keyfile}"

    file { $keyfile:
        ensure  => present,
        path    => "/etc/pki/rpm-gpg/${keyfile}",
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        source  => "puppet:///modules/yum/epel/${keyfile}",
    }

    Yumrepo {
        enabled         => 0,
        gpgcheck        => 1,
        metadata_expire => '7d',
    }

    yumrepo { 'epel':
        enabled    => 1,
        gpgkey     => $gpgkey,
        mirrorlist => "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-${osver}&arch=\$basearch",
        descr      => "Extra Packages for Enterprise Linux ${osver} - \$basearch",
        require    => File[$keyfile],
    }

    yumrepo { 'epel-debuginfo':
        gpgkey     => $gpgkey,
        mirrorlist => "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-${osver}r&arch=\$basearch",
        descr      => "Extra Packages for Enterprise Linux ${osver} - \$basearch - Debug",
        require    => File[$keyfile],
    }

    yumrepo { 'epel-source':
        gpgkey     => $gpgkey,
        mirrorlist => "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-source-${osver}&arch=\$basearch",
        descr      => "Extra Packages for Enterprise Linux ${osver} - \$basearch - Source",
        require    => File[$keyfile],
    }
}
