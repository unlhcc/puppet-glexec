# == Class: glexec::params

class glexec::params {

    $conf_file                  = '/etc/glexec.conf'
    $lcmaps_db_file             = '/etc/lcmaps.db'
    $lcmaps_debug_level         = '3'
    $lcmaps_get_account_policy  = 'glexec'
    $lcmaps_log_file            = '/var/log/glexec/lcas_lcmaps.log'
    $log_destination            = 'syslog'
    $log_level                  = '3'
    $log_file                   = '/var/log/glexec/glexec_log'
    $syslog_facility            = 'LOG_DAEMON'
    $package_name               = 'osg-wn-client-glexec'
    $package_ensure             = 'present'

}
