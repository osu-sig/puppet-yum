#
# yum::key - grabs gpg key for external yum repos
#            for now only grabs keys from urls
#
# usage:
#
# yum::key { 'stealthmonkeys':
#   filename    => 'RPM-GPG-KEY-stealthmonkeys.asc'
#   url         => 'http://passenger.stealthymonkeys.com'
# }

define yum::key (
    $filename = "RPM-GPG-KEY-${name}",
    $url      = ""
) {

    exec { "rpmkey_add_${name}":
        path        => '/usr/bin:/usr/sbin:/bin:/sbin',
        command     => "rpm --import ${url}/${filename}",
        refreshonly => true,
    }
}
