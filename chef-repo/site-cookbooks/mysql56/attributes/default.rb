default['mysql']['password'] = "root"
default['mysql']['files'] = [
    {
        :path      => "/etc/yum.repos.d/",
        :file_name => "mysql56-community.repo"
    },
    {
        :path      => "/etc/pki/rpm-gpg/",
        :file_name => "RPM-GPG-KEY-mysql"
    }
]
default['mysql']['packages'] = [
    # MySQL-client-community + MySQL-shared-community
    'mysql',
    # MySQL-server-community
    'mysql-server',
    # MySQL-devel-community
    'mysql-devel'
]
