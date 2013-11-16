# Remove a yum package via exec, this is done this way because
# package { 'foo': ensure  => purged; } keeps getting called on every
# puppet run. We can't use ensure => absent because of an issue with
# circular dependencies

define yum::remove (
    $package    = $name,
    $ensure     = 'absent'
) {

    if ($ensure in ['absent', 'purged']) {
        exec { "purge_${package}":
            path    => "/usr/bin:/usr/sbin:/bin:/sbin",
            command => "yum remove -y ${package}",
            onlyif  => "rpm -qa ${package} | grep -i ${package}",
        }
    }
}
