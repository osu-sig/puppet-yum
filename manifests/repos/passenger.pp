class yum::repos::passenger {
    if $::osfamily != 'redhat' {
        fail("${::operatingsystem} is not supported")
    }

    Yum::Key['stealthymonkeys'] -> Yumrepo['stealthmonkeys']

    yum::key { 'stealthymonkeys':
        filename => 'RPM-GPG-KEY-stealthymonkeys.asc',
        urls     => 'http://passenger.stealthymonkeys.com',
    }

    yumrepo { 'stealthmonkeys':
        descr      => 'Red Hat Enterprise $releasever - Phusion Passenger',
        baseurl    => 'http://passenger.stealthymonkeys.com/rhel/$releasever/$basearch',
        mirrorlist => 'http://passenger.stealthymonkeys.com/rhel/mirrors',
        enabled    => 1,
        gpgcheck   => 1,
    }
}
