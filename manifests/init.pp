# Class: glexec
#
# gLExec module for use at Holland Computing Center
#
# Defaults match glexec package provided by OSG
#
# Parameters:
#
# [*conf_file*]
#   Location of configuration file for gLExec. Default: /etc/glexec.conf
#
# [*lcmaps_db_file*]
#   Location of LCMAPS configuration file. Default: /etc/lcmaps.db
#
# [*lcmaps_debug_level*]
#   Log level for LCMAPS from {0,..,5}. Default: 3
#
# [*lcmaps_get_account_policy*]
#   Specifies one or more LCMAPS plugin evaulation policies to be executed.
#   Example: "policy1:policy2" - executed in order policies appear in lcmaps_db_file
#   Default: 'glexec'
#
# [*lcmaps_log_file*]
#   Location of LCMAPS output log file. Default: /var/log/glexec/lcas_lcmaps.log
#
# [*log_destination*]
#   Where gLExec, LCAS, and LCMAPS should send logging information.
#   One of either 'file' or 'syslog'. Default: syslog
#
# [*log_level*]
#   Log level for gLExec from {0,..,5}. Default: 3
#
# [*log_file*]
#   Location of gLExec output log file. Default: /var/log/glexec/glexec_log
#   Only used if log_destination is set to 'file'
#
# [*syslog_facility*]
#   Syslog facility to be used. Default: LOG_DAEMON
#
# [*package_name*]
#   The name of the package to install. Default: osg-wn-client-glexec
#
# [*package_ensure*]
#   Ensure the package is present, latest, or absent. Default: present
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class glexec (
    $conf_file                  = $glexec::params::conf_file,
    $lcmaps_db_file             = $glexec::params::lcmaps_db_file,
    $lcmaps_debug_level         = $glexec::params::lcmaps_debug_level,
    $lcmaps_get_account_policy  = $glexec::params::lcmaps_get_account_policy,
    $lcmaps_log_file            = $glexec::params::lcmaps_log_file,
    $log_destination            = $glexec::params::log_destination,
    $log_level                  = $glexec::params::log_level,
    $log_file                   = $glexec::params::log_file,
    $package_name               = $glexec::params::package_name,
    $package_ensure             = $glexec::params::package_ensure,
    $syslog_facility            = $glexec::params::syslog_facility,
    ) inherits glexec::params {

    validate_absolute_path($conf_file)
    validate_absolute_path($lcmaps_db_file)
    validate_string($lcmaps_get_account_policy)
    validate_absolute_path($lcmaps_log_file)
    validate_absolute_path($log_file)
    validate_re($log_destination, [ '^syslog', '^file' ], 'Error: log_destination must be either syslog or file')
    validate_string($package_name)
    validate_re($package_ensure, [ '^present', '^latest', '^absent' ], 'Error: package_ensure must be either present, latest, or absent')
    validate_string($syslog_facility)

    package { $package_name:
        ensure => $package_ensure,
    }

    file { $conf_file:
        ensure  => present,
        owner   => 'root',
        group   => 'glexec',
        mode    => '0640',
        require => Package[$package_name],
        content => template('glexec/glexec.conf.erb'),
    }

}
