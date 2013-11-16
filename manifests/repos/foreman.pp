class yum::repos::foreman {
    yumrepo { 'foreman':
        descr   => 'Foreman repo',
        baseurl => 'http://yum.theforeman.org/stable',
        gpgcheck => '0',
        enabled => '1',
    }
}
